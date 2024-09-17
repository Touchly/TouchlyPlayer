using System.IO;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEngine;
using System.Text;

namespace ReformSim
{
    [ExecuteInEditMode]
    public class ShaderConverter
    {
        public static string m_shaderTemplate = @"Shader ""Custom/CustomShaderName""
{
    Properties
    {
        //To Add Properties
    }

    SubShader
    {
        Tags { ""RenderType"" = ""Opaque"" ""RenderQueue"" = ""Geometry""}

        Pass
        {
            Cull Back
            ZWrite On
            ZTest LEqual
            Blend Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #pragma target 3.5

            #include ""UnityCG.cginc""

            //////////////////////////////////////////////////////////////////////////

            //Vertex Shader Begin
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            //Vertex Shader End

            //////////////////////////////////////////////////////////////////////////
            
            //Fragment Shader Begin
            float4 frag(v2f i) : SV_Target
            {
                return float4(1.0, 1.0, 1.0, 1.0);
            }
            //Fragment Shader End

            ENDCG
        }
    }
}";

        public static string CreateNewShaderContent(string shaderName, string renderType, string renderQueue, string cullType, string zWriteType, string zTestType, string blendType, string pragmaTarget)
        {
            string newShader = Regex.Replace(m_shaderTemplate, "Custom/CustomShaderName", shaderName);
            newShader = Regex.Replace(newShader, "\"RenderType\" = \"Opaque\"", string.Format("\"RenderType\" = \"{0}\"", renderType));
            newShader = Regex.Replace(newShader, "\"RenderQueue\" = \"Geometry\"", string.Format("\"RenderQueue\" = \"{0}\"", renderQueue));
            newShader = Regex.Replace(newShader, "Cull Back", cullType);
            newShader = Regex.Replace(newShader, "ZWrite On", zWriteType);
            newShader = Regex.Replace(newShader, "ZTest LEqual", zTestType);
            newShader = Regex.Replace(newShader, "Blend Off", blendType);
            newShader = Regex.Replace(newShader, "#pragma target 3.5", "#pragma target " + pragmaTarget);

            return newShader;
        }

        public static string GetFileHeaderComment(string inputShaderContent)
        {
            string fileHeaderComment = string.Empty;
            Match matchResult = Regex.Match(inputShaderContent, @"^\s*(//[^\r\n]*\r\n)*", RegexOptions.Singleline | RegexOptions.Multiline);
            if (string.IsNullOrEmpty(matchResult.Groups[0].Value))
            {
                matchResult = Regex.Match(inputShaderContent, @"^\s*(/\*[^\*/]*\*/\s*\r\n)*", RegexOptions.Singleline | RegexOptions.Multiline);
            }
            fileHeaderComment += matchResult.Groups[0].Value;
            //MatchCollection matchResults = Regex.Matches(inputShaderContent, @"//[^\r\n]*\r\n(//[^\r\n]*)", RegexOptions.Singleline | RegexOptions.Multiline);
            //for (int i = 0; i < matchResults.Count; ++i)
            //{
            //    fileHeaderComment += matchResults[i].Groups[1].Value + "\r\n";
            //}

            fileHeaderComment += "\r\n// This shader is converted by ShaderConverter : \r\n// https://u3d.as/2Zim \r\n\r\n\r\n";

            return fileHeaderComment;
        }

        //public static string Convert(string inputShaderContent, string shaderName, string renderType, string renderQueue, string cullType, string zWriteType, string zTestType, string blendType, string pragmaTarget, bool saveDebugFile)
        //{
        //    return inputShaderContent;
        //}

        //public static string Convert(string inputShaderContent)
        //{
        //    return inputShaderContent;
        //}

        public static string ConvertToHLSL(string inputShaderContent, string shaderName, ShaderStage inputShaderStage, string pragmaTarget, bool saveDebugFile)
        {
            int shaderModel = 30;
            switch (pragmaTarget)
            {
                case "3.5":
                    shaderModel = 30;
                    break;
                case "4.0":
                    shaderModel = 40;
                    break;
                case "4.5":
                    shaderModel = 50;
                    break;
                case "4.6":
                    shaderModel = 50;
                    break;
                case "5.0":
                    shaderModel = 50;
                    break;
                default:
                    shaderModel = 30;
                    break;
            }

            if (shaderModel < 40)
            {
                Match texelFetchMatch = Regex.Match(inputShaderContent, @"texelFetch\s*\(", RegexOptions.Singleline | RegexOptions.Multiline);
                if (texelFetchMatch.Success)
                {
                    Debug.LogError("Error: texelFetch() is not supported in HLSL shader model 3.0! Please change pragma target to 4.0 or greater.");
                    return string.Empty;
                }
            }

            StringBuilder outputShaderContent = new StringBuilder(inputShaderContent.Length * 10);
            int ret = ShaderConverterLib.ConvertShaderToHlsl(inputShaderContent, (int)inputShaderStage, outputShaderContent, shaderModel);
            if (ret != 0)
            {
                Debug.LogError("Error: Failed to convert shader: " + shaderName + "; Return: " + ret);
                string logContent = File.ReadAllText("ShaderConverter.log");
                Debug.LogError(logContent);
                return string.Empty;
            }

            string strOutputShaderContent = outputShaderContent.ToString();
            strOutputShaderContent = Regex.Replace(strOutputShaderContent, @"\r?\n", "\r\n");

            // Convert sampler's name
            strOutputShaderContent = Regex.Replace(strOutputShaderContent, @"(\b)_(\w+)_sampler(\W)", "$1sampler$2$3");

            if (saveDebugFile)
            {
                File.WriteAllText("TempShader.hlsl", strOutputShaderContent);
            }

            return strOutputShaderContent;
        }

        public static string RemoveSmallBracketContent(string content)
        {
            while (content.Contains("("))
            {
                content = Regex.Replace(content, "\\([^)(]*\\)", "");
            }

            return content;
        }

        public static string FormatMultipleLinesIndent(string content, string preStr)
        {
            string outputStr = string.Empty;
            string[] lines = Regex.Split(content, "\r\n");
            string replacement = string.Format("{0}$1\r\n", preStr);
            for (int i = 0; i < lines.Length; ++i)
            {
                if (string.IsNullOrEmpty(lines[i]))
                {
                    if (i == 0 || i == lines.Length - 1)
                    {
                        continue;
                    }

                    outputStr += "\r\n";
                    continue;
                }

                string result = Regex.Replace(lines[i], "^(.*)$", replacement);
                outputStr += result;
            }

            return outputStr;
        }

        public static string AddProperties(string inputShaderContent)
        {
            return inputShaderContent;
        }

        public static string AddTexture2DProperties(string inputShaderContent, string name)
        {
            return AddProperties(inputShaderContent, name, "2D", "sampler2D", @"""black"" {}");
        }

        public static string AddTexture3DProperties(string inputShaderContent, string name)
        {
            return AddProperties(inputShaderContent, name, "3D", "sampler3D", @"""black"" {}");
        }

        public static string AddTextureCubeProperties(string inputShaderContent, string name)
        {
            return AddProperties(inputShaderContent, name, "Cube", "samplerCube", @"""black"" {}");
        }

        public static string AddVectorProperties(string inputShaderContent, string name)
        {
            return AddProperties(inputShaderContent, name, "Vector", "float4", "(0,0,0,0)");
        }

        public static string AddColorProperties(string inputShaderContent, string name)
        {
            return AddProperties(inputShaderContent, name, "Color", "float4", "(0,0,0,0)");
        }

        public static string AddIntProperties(string inputShaderContent, string name)
        {
            return AddProperties(inputShaderContent, name, "int", "int", "0");
        }

        public static string AddFloatProperties(string inputShaderContent, string name)
        {
            return AddProperties(inputShaderContent, name, "float", "float", "0");
        }

        public static string AddProperties(string inputShaderContent, string name, string propertyType, string variableType, string initValue)
        {
            string property = @"name (""ShowName"", type) = initValue";
            property = Regex.Replace(property, "name", name);

            string showName = name;
            if (name == "_MainTex")
            {
                showName += " / iChannel0";
            }
            else if (name == "_SecondTex")
            {
                showName += " / iChannel1";
            }
            else if (name == "_ThirdTex")
            {
                showName += " / iChannel2";
            }
            else if (name == "_FourthTex")
            {
                showName += " / iChannel3";
            }
            property = Regex.Replace(property, "ShowName", showName);

            property = Regex.Replace(property, "type", propertyType);
            property = Regex.Replace(property, "initValue", initValue);
            inputShaderContent = Regex.Replace(inputShaderContent, @"//To Add Properties", property + "\r\n        $0");

            //string variable = variableType + " _" + name + ";";
            //inputShaderContent = Regex.Replace(inputShaderContent, "//To Add Variables", "$0\r\n            " + variable);

            return inputShaderContent;
        }

        public static bool Save(string shaderContent, string filePathName)
        {
            if (File.Exists(filePathName))
            {
                string message = string.Format("The file already exists:\n{0}\nDo you want to replace it?", filePathName);
                bool ret = EditorUtility.DisplayDialog("Warning", message, "OK", "Cancel");
                if (!ret)
                {
                    return false;
                }
            }

            File.WriteAllText(filePathName, shaderContent);
            return true;
        }

        public static bool CreateMaterial(string shaderName, string matFilePathName)
        {
            if (File.Exists(matFilePathName))
            {
                string message = string.Format("The file already exists:\n{0}\nDo you want to replace it?", matFilePathName);
                bool ret = EditorUtility.DisplayDialog("Warning", message, "OK", "Cancel");
                if (!ret)
                {
                    return false;
                }
            }

            Shader shader = Shader.Find(shaderName);
            if (!shader)
            {
                Debug.LogError("Error: Can't find shader: " + shaderName);
                return false;
            }
            
            Material material = new Material(shader);
            AssetDatabase.CreateAsset(material, matFilePathName);

            return true;
        }
    }
}
