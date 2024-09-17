using System.Text.RegularExpressions;
using UnityEngine;

namespace ReformSim
{
    [ExecuteInEditMode]
    public class GLSLConverter : ShaderConverter
    {
        public static string Convert(string inputShaderContent, string shaderName, ShaderStage inputShaderStage,
            string renderType, string renderQueue, string cullType, string zWriteType, string zTestType, string blendType, string pragmaTarget, bool saveDebugFile)
        {
            string outputShaderContent = CreateNewShaderContent(shaderName, renderType, renderQueue, cullType, zWriteType, zTestType, blendType, pragmaTarget);
            outputShaderContent = Regex.Replace(outputShaderContent, @"\r?\n", "\r\n");

            inputShaderContent = Regex.Replace(inputShaderContent, @"\t", "    ");
            //inputShaderContent = Regex.Replace(inputShaderContent, @",\s+", ", ");
            inputShaderContent = Regex.Replace(inputShaderContent, @"\r?\n", "\r\n");

            string fileHeaderComment = GetFileHeaderComment(inputShaderContent);

            string hlslShaderContent = ConvertToHLSL(inputShaderContent, shaderName, inputShaderStage, pragmaTarget, saveDebugFile);
            if (string.IsNullOrEmpty(hlslShaderContent))
            {
                return string.Empty;
            }

            inputShaderContent = hlslShaderContent;

            inputShaderContent = Regex.Replace(inputShaderContent, @"((?:static)?\s*const )(.+;)", "static const $2");
            
            inputShaderContent = FormatMultipleLinesIndent(inputShaderContent, "            ");

            if (inputShaderStage == ShaderStage.Vertex)
            {
                inputShaderContent = Regex.Replace(inputShaderContent, @" main\(", @" vert(");
                inputShaderContent = Regex.Replace(inputShaderContent, @"mul\(aVertex, _16_uMVP\)", "UnityObjectToClipPos(aVertex)");
                outputShaderContent = Regex.Replace(outputShaderContent, @" *//Vertex Shader Begin[\s\S]*//Vertex Shader End", inputShaderContent);
                outputShaderContent = Regex.Replace(outputShaderContent, @"(\b)v2f(\W)", "$1SPIRV_Cross_Output$2");
            }
            else if (inputShaderStage == ShaderStage.Fragment)
            {
                inputShaderContent = Regex.Replace(inputShaderContent, @" main\(", @" frag(");
                outputShaderContent = Regex.Replace(outputShaderContent, @" *//Fragment Shader Begin[\s\S]*//Fragment Shader End", inputShaderContent);
            }

            outputShaderContent = AddProperties(outputShaderContent);

            if (!string.IsNullOrEmpty(inputShaderContent))
            {
                Debug.Log("Shader is converted successfully: " + shaderName);
            }
            
            outputShaderContent = fileHeaderComment + outputShaderContent;

            return outputShaderContent;
        }

        public static new string AddProperties(string outputShaderContent)
        {
            MatchCollection matchResults = Regex.Matches(outputShaderContent, @"uniform\s+(\w+)\s+(\w+)\s*;", RegexOptions.Singleline | RegexOptions.Multiline);
            for (int i=0; i< matchResults.Count; ++i)
            {
                string uniformType = matchResults[i].Groups[1].Value;
                string uniformName = matchResults[i].Groups[2].Value;

                switch (uniformType)
                {
                    case "float":
                        outputShaderContent = AddFloatProperties(outputShaderContent, uniformName);
                        break;
                    case "float4":
                        outputShaderContent = AddVectorProperties(outputShaderContent, uniformName);
                        break;
                    case "int":
                        outputShaderContent = AddIntProperties(outputShaderContent, uniformName);
                        break;
                    case "sampler2D":
                        outputShaderContent = AddTexture2DProperties(outputShaderContent, uniformName);
                        break;
                    case "sampler3D":
                    case "samplerCube":
                        outputShaderContent = AddTextureCubeProperties(outputShaderContent, uniformName);
                        break;
                    default:
                        break;
                }
            }
            
            matchResults = Regex.Matches(outputShaderContent, @"Texture(2D|3D|Cube)<\w+>\s+(\w+)\s*[;|:]", RegexOptions.Singleline | RegexOptions.Multiline);
            for (int i = 0; i < matchResults.Count; ++i)
            {
                string textureType = matchResults[i].Groups[1].Value;
                string textureName = matchResults[i].Groups[2].Value;

                switch (textureType)
                {
                    case "2D":
                        outputShaderContent = AddTexture2DProperties(outputShaderContent, textureName);
                        break;
                    case "3D":
                    case "Cube":
                        outputShaderContent = AddTextureCubeProperties(outputShaderContent, textureName);
                        break;
                    default:
                        break;
                }
            }

            return outputShaderContent;
        }
    }
}
