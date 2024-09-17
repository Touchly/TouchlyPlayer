using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using UnityEngine;

namespace ReformSim
{
    [ExecuteInEditMode]
    public class ImageShaderConverter : ShaderConverter
    {
        public static string Convert(string inputShaderContent, string shaderName,
            string renderType, string renderQueue, string cullType, string zWriteType, string zTestType, string blendType, string pragmaTarget, bool saveDebugFile,
            int mainTexType, int secondTexType, int thirdTexType, int fourthTexType)
        {
            string outputShaderContent = CreateNewShaderContent(shaderName, renderType, renderQueue, cullType, zWriteType, zTestType, blendType, pragmaTarget);
            outputShaderContent = Regex.Replace(outputShaderContent, @"\r?\n", "\r\n");

            inputShaderContent = Regex.Replace(inputShaderContent, @"\t", "    ");
            //inputShaderContent = Regex.Replace(inputShaderContent, @",\s+", ", ");
            inputShaderContent = Regex.Replace(inputShaderContent, @"\r?\n", "\r\n");

            string fileHeaderComment = GetFileHeaderComment(inputShaderContent);

            string glslShaderContent = ConvertToGLSL(inputShaderContent, saveDebugFile, mainTexType, secondTexType, thirdTexType, fourthTexType);
            if (string.IsNullOrEmpty(glslShaderContent))
            {
                return string.Empty;
            }

            string hlslShaderContent = ConvertToHLSL(glslShaderContent, shaderName, ShaderStage.Fragment, pragmaTarget, saveDebugFile);
            if (string.IsNullOrEmpty(hlslShaderContent))
            {
                return string.Empty;
            }

            inputShaderContent = hlslShaderContent;

            // variables: initialize your variables!Don't assume they'll be set to zero by default
            // TODO...

            inputShaderContent = Regex.Replace(inputShaderContent, @"((?:static)?\s*const )(.+;)", "static const $2");

            inputShaderContent = Regex.Replace(inputShaderContent, "uniform float _iTime;\r\n", "");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)_iTime(\W)", "$1_Time.y$2");
            inputShaderContent = Regex.Replace(inputShaderContent, "uniform float _iTimeDelta;\r\n", "");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)_iTimeDelta(\W)", "$1unity_DeltaTime.x$2");
            inputShaderContent = Regex.Replace(inputShaderContent, "uniform float3 _iResolution;\r\n", "");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)_iResolution(\W)", "$1_ScreenParams$2");
            
            inputShaderContent = Regex.Replace(inputShaderContent, @"uniform float _iChannelTime\[4\];\r\n", "");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)_iChannelTime\[\d\](\W)", "$1_Time.y$2");

            inputShaderContent = Regex.Replace(inputShaderContent, @" main\(", @" frag(");

            inputShaderContent = FormatMultipleLinesIndent(inputShaderContent, "            ");

            outputShaderContent = Regex.Replace(outputShaderContent, @" *//Fragment Shader Begin[\s\S]*//Fragment Shader End", inputShaderContent, RegexOptions.Multiline);
            
            outputShaderContent = AddProperties(outputShaderContent);

            // Image shaders: fragColor is used as output channel. It is not, for now, mandatory but recommended to leave the alpha channel to 1.0.
            // Sound shaders: the mainSound() function returns a vec2 containing the left and right(stereo) sound channel wave data.

            if (!string.IsNullOrEmpty(inputShaderContent))
            {
                Debug.Log("Shader is converted successfully: " + shaderName);
            }

            outputShaderContent = fileHeaderComment + outputShaderContent;

            return outputShaderContent;
        }

        public static string ConvertToGLSL(string inputShaderContent, bool saveDebugFile, int mainTexType, int secondTexType, int thirdTexType, int fourthTexType)
        {
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iTime(\W)", "$1_iTime$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iTimeDelta(\W)", "$1_iTimeDelta$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iResolution(\W)", "$1_iResolution$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iFrame(\W)", "$1_iFrame$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iFrameRate(\W)", "$1_iFrameRate$2");

            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannel0(\W)", "$1_MainTex$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannel1(\W)", "$1_SecondTex$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannel2(\W)", "$1_ThirdTex$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannel3(\W)", "$1_FourthTex$2");
            
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[0\](?:.xy)?(\W)", "$1_MainTex_TexelSize.zw$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[0\].x(\W)", "$1_MainTex_TexelSize.z$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[0\].y(\W)", "$1_MainTex_TexelSize.w$2");

            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[1\](?:.xy)?(\W)", "$1_SecondTex_TexelSize.zw$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[1\].x(\W)", "$1_SecondTex_TexelSize.z$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[1\].y(\W)", "$1_SecondTex_TexelSize.w$2");
                                                                                             
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[2\](?:.xy)?(\W)", "$1_ThirdTex_TexelSize.zw$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[2\].x(\W)", "$1_ThirdTex_TexelSize.z$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[2\].y(\W)", "$1_ThirdTex_TexelSize.w$2");
                                                                                             
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[3\](?:.xy)?(\W)", "$1_Fourth_TexelSize.zw$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[3\].x(\W)", "$1_Fourth_TexelSize.z$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelResolution\[3\].y(\W)", "$1_Fourth_TexelSize.w$2");

            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iChannelTime(\W)", "$1_iChannelTime$2");

            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iMouse(\W)", "$1_iMouse$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iDate(\W)", "$1_iDate$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\b)iSampleRate(\W)", "$1_iSampleRate$2");

            string fragHeader = "#version 310 es\r\n\r\n";
            fragHeader += "precision mediump float;\r\n\r\n";
            fragHeader += GetShaderDefaultInputs(inputShaderContent, mainTexType, secondTexType, thirdTexType, fourthTexType) + "\r\n";
            fragHeader += "out vec4 fragColor;\r\n\r\n";

            inputShaderContent = fragHeader + inputShaderContent;

            Match mainFuncParas = Regex.Match(inputShaderContent, @"void\s+mainImage\s*\(\s*out\s+vec4\s+(.+?)\s*,\s*(?:in)?\s*vec2\s+(.+?)\s*\)", RegexOptions.Singleline | RegexOptions.Multiline);
            string fragColor = mainFuncParas.Groups[1].Value;
            if (string.IsNullOrEmpty(fragColor))
            {
                Debug.LogError("The format of parameter of mainImage() is not correct: " + fragColor);
                return string.Empty;
            }
            string fragCoord = mainFuncParas.Groups[2].Value;
            if (string.IsNullOrEmpty(fragCoord))
            {
                Debug.LogError("The format of parameter of mainImage() is not correct: " + fragCoord);
                return string.Empty;
            }
            
            Match mainFuncContentMatch = Regex.Match(inputShaderContent, @"void\s+mainImage[^\{]+\{([^\{\}]*(((?<Open>\{)[^\{\}]*)+((?<-Open>\})[^\{\}]*)+)*(?(Open)(?!)))\}", RegexOptions.Singleline | RegexOptions.Multiline);
            string oldMainFuncContent = mainFuncContentMatch.Groups[1].Value;
            string newMainFuncContent = Regex.Replace(oldMainFuncContent, @"(\b)" + fragColor + @"(\W)", "$1fragColor$2");
            newMainFuncContent = Regex.Replace(newMainFuncContent, @"(\b)" + fragCoord + @"(\W)", "$1gl_FragCoord.xy$2");
            inputShaderContent = inputShaderContent.Replace(oldMainFuncContent, newMainFuncContent);

            inputShaderContent = Regex.Replace(inputShaderContent, @"void\s+mainImage\s*\([^\)]+\)", @"void main()", RegexOptions.Singleline | RegexOptions.Multiline);
            
            if (saveDebugFile)
            {
                File.WriteAllText("TempShader.frag", inputShaderContent);
            }

            return inputShaderContent;
        }

        public static string ManualConvert(string inputShaderContent, string shaderName, string renderType, string renderQueue, string cullType, string zWriteType, string zTestType, string blendType, string pragmaTarget)
        {
            string outputShaderContent = CreateNewShaderContent(shaderName, renderType, renderQueue, cullType, zWriteType, zTestType, blendType, pragmaTarget);

            inputShaderContent = Convert(inputShaderContent);

            //Match mainFuncMatch = Regex.Match(inputShaderContent, @"void\s+mainImage[^\{]+\{(.+)\}\s*$", RegexOptions.Singleline | RegexOptions.Multiline);
            Match mainFuncMatch = Regex.Match(inputShaderContent, @"void\s+mainImage[^\{]+\{([^\{\}]*(((?<Open>\{)[^\{\}]*)+((?<-Open>\})[^\{\}]*)+)*(?(Open)(?!)))\}", RegexOptions.Singleline | RegexOptions.Multiline);
            //inputShaderContent.replaceAll("(?<!:)\\/\\/.*|\\/\\*(\\s|.)*?\\*\\/", "");
            string mainFuncContent = FormatMultipleLinesIndent(mainFuncMatch.Groups[1].Value, "            ");
            outputShaderContent = Regex.Replace(outputShaderContent, " *//To Insert Main Function\r\n", mainFuncContent);

            Match otherFunctionsMatch = Regex.Match(inputShaderContent, @"(.*)(?=void mainImage)", RegexOptions.Singleline | RegexOptions.Multiline);
            string otherFuncsContent = FormatMultipleLinesIndent(otherFunctionsMatch.Groups[1].Value, "            ");
            outputShaderContent = Regex.Replace(outputShaderContent, " *//To Insert Functions\r\n", otherFuncsContent);

            outputShaderContent = Regex.Replace(outputShaderContent, "fragColor =", "return ");

            outputShaderContent = AddProperties(outputShaderContent);

            return outputShaderContent;
        }

        public static string Convert(string inputShaderContent)
        {
            inputShaderContent = Regex.Replace(inputShaderContent, @"\t", "    ");
            inputShaderContent = Regex.Replace(inputShaderContent, @",\s+", ", ");

            Match mainFuncParas = Regex.Match(inputShaderContent, @"void\s+mainImage\(\s*out\s*vec4\s*(.+?)\s*\,\s*in\s*vec2\s*(.+?)\s*\)", RegexOptions.Singleline | RegexOptions.Multiline);
            string fragColor = mainFuncParas.Groups[1].Value;
            string fragCoord = mainFuncParas.Groups[2].Value;

            inputShaderContent = Regex.Replace(inputShaderContent, fragColor, "fragColor");
            inputShaderContent = Regex.Replace(inputShaderContent, fragCoord, "fragCoord");

            inputShaderContent = Regex.Replace(inputShaderContent, @"\bprecision\s+highp\s+float\b", "#define float float");
            inputShaderContent = Regex.Replace(inputShaderContent, @"\bprecision\s+mediump\s+float\b", "#define min16float float");
            inputShaderContent = Regex.Replace(inputShaderContent, @"\bprecision\s+lowp\s+float\b", "#define min10float float");

            //highp vec4 -> float4
            //mediump vec4 -> half4
            //lowp vec4->fixed4

            inputShaderContent = Regex.Replace(inputShaderContent, @"\bprecision\s+highp\s+int\b", "#define int int");
            //inputShaderContent = Regex.Replace(inputShaderContent, @"\bprecision\s+highp\s+int\b", "#define min16int int");
            inputShaderContent = Regex.Replace(inputShaderContent, @"\bprecision\s+mediump\s+int\b", "#define min12int int");

            inputShaderContent = Regex.Replace(inputShaderContent, @"([^a-zA-Z0-9_])vec(\d)", "$1float$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"([\W])bvec(\d)", "$1bool$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"([\W])ivec(\d)", "$1int$2");

            inputShaderContent = ReplaceDataVector(inputShaderContent, "float2");
            inputShaderContent = ReplaceDataVector(inputShaderContent, "float3");
            inputShaderContent = ReplaceDataVector(inputShaderContent, "float4");

            inputShaderContent = ReplaceDataVector(inputShaderContent, "half2");
            inputShaderContent = ReplaceDataVector(inputShaderContent, "half3");
            inputShaderContent = ReplaceDataVector(inputShaderContent, "half4");

            inputShaderContent = ReplaceDataVector(inputShaderContent, "fixed2");
            inputShaderContent = ReplaceDataVector(inputShaderContent, "fixed3");
            inputShaderContent = ReplaceDataVector(inputShaderContent, "fixed4");
            
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat2( |\()", "$1float2x2$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat2x3( |\()", "$1float2x3$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat2x4( |\()", "$1float2x4$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat3( |\()", "$1float3x3$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat3x2( |\()", "$1float2x2$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat3x4( |\()", "$1float2x4$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat4( |\()", "$1float4x4$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat4x2( |\()", "$1float4x2$2");
            inputShaderContent = Regex.Replace(inputShaderContent, @"(\W)mat4x3( |\()", "$1float4x3$2");

            //TODO Row-major matrices to Column-major matrices

            inputShaderContent = Regex.Replace(inputShaderContent, "(const .+;)", "static $1");

            //inputShaderContent = Regex.Replace(inputShaderContent, "mod", "fmod");
            inputShaderContent = Regex.Replace(inputShaderContent, "mix", "lerp");
            inputShaderContent = Regex.Replace(inputShaderContent, "fract", "frac");
            inputShaderContent = Regex.Replace(inputShaderContent, "inversesqrt", "rsqrt");
            inputShaderContent = Regex.Replace(inputShaderContent, "texture", "tex2D");
            inputShaderContent = Regex.Replace(inputShaderContent, "tex2DLod", "tex2Dlod");
            inputShaderContent = Regex.Replace(inputShaderContent, "tex2DGrad", "tex2Dgrad");
            inputShaderContent = Regex.Replace(inputShaderContent, "textureGrad", "tex2Dgrad");
            inputShaderContent = Regex.Replace(inputShaderContent, "refrac", "refract");
            inputShaderContent = Regex.Replace(inputShaderContent, @"atan\(([^,]+?)\,([^,]+?)\)", "atan2($2,$1)");

            inputShaderContent = Regex.Replace(inputShaderContent, @"(\s|\()*line\s*", "$1lineFunc");
            inputShaderContent = Regex.Replace(inputShaderContent, @"\blineadj\b", "lineadjFunc");
            inputShaderContent = Regex.Replace(inputShaderContent, @"\blinear\b", "linearFunc");

            inputShaderContent = Regex.Replace(inputShaderContent, "dFdx", "ddx");
            inputShaderContent = Regex.Replace(inputShaderContent, "dFdy", "ddy");
            inputShaderContent = Regex.Replace(inputShaderContent, "dFdxCoarse", "ddx_coarse");
            inputShaderContent = Regex.Replace(inputShaderContent, "dFdyCoarse", "ddy_coarse");
            inputShaderContent = Regex.Replace(inputShaderContent, "dFdxFine", "ddx_fine");
            inputShaderContent = Regex.Replace(inputShaderContent, "dFdyFine", "ddy_fine");

            inputShaderContent = Regex.Replace(inputShaderContent, "interpolateAtCentroid", "EvaluateAttributeAtCentroid");
            inputShaderContent = Regex.Replace(inputShaderContent, "interpolateAtSample", "EvaluateAttributeAtSample");
            inputShaderContent = Regex.Replace(inputShaderContent, "interpolateAtOffset", "EvaluateAttributeSnapped");
            
            inputShaderContent = Regex.Replace(inputShaderContent, "fma", "mad");

            inputShaderContent = Regex.Replace(inputShaderContent, @"\bi\W", "iVar");

            inputShaderContent = Regex.Replace(inputShaderContent, "iChannel0", "_MainTex");
            inputShaderContent = Regex.Replace(inputShaderContent, "iChannel1", "_SecondTex");
            inputShaderContent = Regex.Replace(inputShaderContent, "iChannel2", "_ThirdTex");
            inputShaderContent = Regex.Replace(inputShaderContent, "iChannel3", "_FourthTex");

            inputShaderContent = Regex.Replace(inputShaderContent, "iTime", "_Time.y");
            inputShaderContent = Regex.Replace(inputShaderContent, "iTimeDelta", "unity_DeltaTime.x");

            inputShaderContent = Regex.Replace(inputShaderContent, "iFrameRate", "_iFrameRate");
            inputShaderContent = Regex.Replace(inputShaderContent, "iFrame", "_iFrame");
            inputShaderContent = Regex.Replace(inputShaderContent, "iMouse", "_iMouse");
            inputShaderContent = Regex.Replace(inputShaderContent, "iDate", "_iDate");

            inputShaderContent = Regex.Replace(inputShaderContent, "iResolution.", "_ScreenParams.");
            inputShaderContent = Regex.Replace(inputShaderContent, @"iResolution.((x|y){1,2})?", "1");
            inputShaderContent = Regex.Replace(inputShaderContent, @"iResolution(\.(x|y){1,2})?", "1");
            inputShaderContent = Regex.Replace(inputShaderContent, @"fragCoord.xy / iResolution.xy", "i.uv");
            inputShaderContent = Regex.Replace(inputShaderContent, @"fragCoord(.xy)?", "(i.uv * _ScreenParams.xy)");

            inputShaderContent = ReplaceVectorMultiply(inputShaderContent);

            inputShaderContent = Regex.Replace(inputShaderContent, @"\r\n( *)for(\s*)\(", "\r\n$1[unroll(100)]\r\n$1for (");

            inputShaderContent = Regex.Replace(inputShaderContent, @"texelFetch", "tex2Dlod");

            inputShaderContent = Regex.Replace(inputShaderContent, "gl_FragCoord", "((i.screenCoord.xy/i.screenCoord.w)*_ScreenParams.xy)");

            // Special Conversion
            inputShaderContent = Regex.Replace(inputShaderContent, @"(tex2Dlod\()([^,]+\,)([^)]+\)?[)]+.+(?=\)))", "$1$2float4($3, 0)");
            
            // process texture( iChannel0, vec2(uv.x,1.0-uv.y), lod );
            inputShaderContent = Regex.Replace(inputShaderContent, @"tex2D\(([^,]+)\,\s*float2\(([^,].+)\)\,(.+)\)", "tex2Dlod($1, float4($2, float2($3,$3)))");

            //UV coordinates in GLSL have 0 at the top and increase downwards,
            //in HLSL 0 is at the bottom and increases upwards,
            //so you may need to use uv.y = 1 – uv.y at some point.

            return inputShaderContent;
        }

        /* ------------------------ Shader Toy Built-in Input Uniforms -----------------------------
        uniform vec3      iResolution;           // viewport resolution (in pixels)
        uniform float     iTime;                 // shader playback time (in seconds)
        uniform float     iTimeDelta;            // render time (in seconds)
        uniform float     iFrameRate;            // shader frame rate
        uniform int       iFrame;                // shader playback frame
        uniform float     iChannelTime[4];       // channel playback time (in seconds)
        uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
        uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click      
        uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
        uniform vec4      iDate;                 // (year, month, day, time in seconds)
        uniform float     iSampleRate;           // sound sample rate (i.e., 44100)
        -------------------------------------------------------------------------------------*/
        public static string GetShaderDefaultInputs(string inputShaderContent, int mainTexType, int secondTexType, int thirdTexType, int fourthTexType)
        {
            string defaultInputs = "";
            if (inputShaderContent.Contains("HW_PERFORMANCE"))
            {
                defaultInputs += "#define HW_PERFORMANCE 1\r\n\r\n";
            }

            if (inputShaderContent.Contains("_iResolution"))
            {
                defaultInputs += "uniform vec3 _iResolution;\r\n";
            }
            if (inputShaderContent.Contains("_iTime"))
            {
                defaultInputs += "uniform float _iTime;\r\n";
            }
            if (inputShaderContent.Contains("_iTimeDelta"))
            {
                defaultInputs += "uniform float _iTimeDelta;\r\n";
            }
            if (inputShaderContent.Contains("_iFrameRate"))
            {
                defaultInputs += "uniform float _iFrameRate;\r\n";
            }
            if (inputShaderContent.Contains("_iFrame"))
            {
                defaultInputs += "uniform int _iFrame;\r\n";
            }
            
            if (inputShaderContent.Contains("_iChannelTime"))
            {
                defaultInputs += "uniform float _iChannelTime[4];\r\n";
            }

            //TODO: Need to check if texture exist
            if (inputShaderContent.Contains("_MainTex"))
            {
                if (mainTexType == 0)
                {
                    defaultInputs += "uniform sampler2D _MainTex;\r\n";
                }
                else
                {
                    defaultInputs += "uniform samplerCube _MainTex;\r\n";
                }
            }
            if (inputShaderContent.Contains("_SecondTex"))
            {
                if (secondTexType == 0)
                {
                    defaultInputs += "uniform sampler2D _SecondTex;\r\n";
                }
                else
                {
                    defaultInputs += "uniform samplerCube _SecondTex;\r\n";
                }
            }
            if (inputShaderContent.Contains("_ThirdTex"))
            {
                if (thirdTexType == 0)
                {
                    defaultInputs += "uniform sampler2D _ThirdTex;\r\n";
                }
                else
                {
                    defaultInputs += "uniform samplerCube _ThirdTex;\r\n";
                }
            }
            if (inputShaderContent.Contains("_FourthTex"))
            {
                if (fourthTexType == 0)
                {
                    defaultInputs += "uniform sampler2D _FourthTex;\r\n";
                }
                else
                {
                    defaultInputs += "uniform samplerCube _FourthTex;\r\n";
                }
            }

            if (inputShaderContent.Contains("_MainTex_TexelSize"))
            {
                defaultInputs += "uniform vec4 _MainTex_TexelSize;\r\n";
            }
            if (inputShaderContent.Contains("_SecondTex_TexelSize"))
            {
                defaultInputs += "uniform vec4 _SecondTex_TexelSize;\r\n";
            }
            if (inputShaderContent.Contains("_ThirdTex_TexelSize"))
            {
                defaultInputs += "uniform vec4 _ThirdTex_TexelSize;\r\n";
            }
            if (inputShaderContent.Contains("_FourthTex_TexelSize"))
            {
                defaultInputs += "uniform vec4 _FourthTex_TexelSize;\r\n";
            }

            if (inputShaderContent.Contains("_iMouse"))
            {
                defaultInputs += "uniform vec4 _iMouse;\r\n";
            }

            if (inputShaderContent.Contains("_iDate"))
            {
                defaultInputs += "uniform vec4 _iDate;\r\n";
            }

            if (inputShaderContent.Contains("_iSampleRate"))
            {
                defaultInputs += "uniform float _iSampleRate;\r\n";
            }

            return defaultInputs;
        }

        public static new string AddProperties(string outputShaderContent)
        {
            //if (outputShaderContent.Contains("_iFrame"))
            //{
            //    outputShaderContent = AddIntProperties(outputShaderContent, "_iFrame");
            //}
            //if (outputShaderContent.Contains("_iFrameRate"))
            //{
            //    outputShaderContent = AddFloatProperties(outputShaderContent, "_iFrameRate");
            //}

            //if (outputShaderContent.Contains("_MainTex"))
            //{
            //    outputShaderContent = AddTexture2DProperties(outputShaderContent, "_MainTex");
            //}
            //if (outputShaderContent.Contains("_SecondTex"))
            //{
            //    outputShaderContent = AddTexture2DProperties(outputShaderContent, "_SecondTex");
            //}
            //if (outputShaderContent.Contains("_ThirdTex"))
            //{
            //    outputShaderContent = AddTexture2DProperties(outputShaderContent, "_ThirdTex");
            //}
            //if (outputShaderContent.Contains("_FourthTex"))
            //{
            //    outputShaderContent = AddTexture2DProperties(outputShaderContent, "_FourthTex");
            //}

            //if (outputShaderContent.Contains("_iMouse"))
            //{
            //    outputShaderContent = AddVectorProperties(outputShaderContent, "_iMouse");
            //}

            //if (outputShaderContent.Contains("_iDate"))
            //{
            //    outputShaderContent = AddVectorProperties(outputShaderContent, "_iDate");
            //}

            //if (outputShaderContent.Contains("_iSampleRate"))
            //{
            //    outputShaderContent = AddFloatProperties(outputShaderContent, "_iSampleRate");
            //}

            MatchCollection matchResults = Regex.Matches(outputShaderContent, @"uniform\s+(\w+)\s+(\w+)\s*;", RegexOptions.Singleline | RegexOptions.Multiline);
            for (int i = 0; i < matchResults.Count; ++i)
            {
                string uniformType = matchResults[i].Groups[1].Value;
                string uniformName = matchResults[i].Groups[2].Value;

                switch (uniformType)
                {
                    case "float":
                        outputShaderContent = AddFloatProperties(outputShaderContent, uniformName);
                        break;
                    case "float4":
                        if (!uniformName.Contains("_TexelSize"))
                        {
                            outputShaderContent = AddVectorProperties(outputShaderContent, uniformName);
                        }
                        break;
                    case "int":
                        outputShaderContent = AddIntProperties(outputShaderContent, uniformName);
                        break;
                    //case "sampler2D":
                    //    outputShaderContent = AddTexture2DProperties(outputShaderContent, uniformName);
                    //    break;
                    //case "sampler3D":
                    //case "samplerCube":
                    //    outputShaderContent = AddTextureCubeProperties(outputShaderContent, uniformName);
                    //    break;
                    default:
                        break;
                }
            }

            // Add texture properties sequentially
            string pattern = string.Format(@"uniform\s+sampler(2D|3D|Cube)\s+(_MainTex)\s*;");
            outputShaderContent = AddTexturProperties(outputShaderContent, pattern);
            pattern = string.Format(@"uniform\s+sampler(2D|3D|Cube)\s+(_SecondTex)\s*;");
            outputShaderContent = AddTexturProperties(outputShaderContent, pattern);
            pattern = string.Format(@"uniform\s+sampler(2D|3D|Cube)\s+(_ThirdTex)\s*;");
            outputShaderContent = AddTexturProperties(outputShaderContent, pattern);
            pattern = string.Format(@"uniform\s+sampler(2D|3D|Cube)\s+(_FourthTex)\s*;");
            outputShaderContent = AddTexturProperties(outputShaderContent, pattern);

            //matchResults = Regex.Matches(outputShaderContent, @"Texture(2D|3D|Cube)<\w+>\s+(\w+)\s*[;|:]", RegexOptions.Singleline | RegexOptions.Multiline);
            //for (int i = 0; i < matchResults.Count; ++i)
            //{
            //    string textureType = matchResults[i].Groups[1].Value;
            //    string textureName = matchResults[i].Groups[2].Value;

            //    switch (textureType)
            //    {
            //        case "2D":
            //            outputShaderContent = AddTexture2DProperties(outputShaderContent, textureName);
            //            break;
            //        case "3D":
            //        case "Cube":
            //            outputShaderContent = AddTextureCubeProperties(outputShaderContent, textureName);
            //            break;
            //        default:
            //            break;
            //    }
            //}

            // Add texture properties sequentially
            pattern = string.Format(@"Texture(2D|3D|Cube)<\w+>\s+(_MainTex)\s*[;|:]");
            outputShaderContent = AddTexturProperties(outputShaderContent, pattern);
            pattern = string.Format(@"Texture(2D|3D|Cube)<\w+>\s+(_SecondTex)\s*[;|:]");
            outputShaderContent = AddTexturProperties(outputShaderContent, pattern);
            pattern = string.Format(@"Texture(2D|3D|Cube)<\w+>\s+(_ThirdTex)\s*[;|:]");
            outputShaderContent = AddTexturProperties(outputShaderContent, pattern);
            pattern = string.Format(@"Texture(2D|3D|Cube)<\w+>\s+(_FourthTex)\s*[;|:]");
            outputShaderContent = AddTexturProperties(outputShaderContent, pattern);

            return outputShaderContent;
        }

        public static string AddTexturProperties(string outputShaderContent, string pattern)
        {
            MatchCollection matchResults = Regex.Matches(outputShaderContent, pattern, RegexOptions.Singleline | RegexOptions.Multiline);
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

        public static string ReplaceDataVector(string inputShaderContent, string dataType)
        {
            string pattern = string.Format(@"\W{0}\s*\(([^\(\)]*(((?<Open>\()[^\(\)]*)+((?<-Open>\))[^\(\)]*)+)*(?(Open)(?!)))\)", dataType);
            MatchCollection matchResults = Regex.Matches(inputShaderContent, pattern, RegexOptions.Singleline | RegexOptions.Multiline);
            for (int i = 0; i < matchResults.Count; ++i)
            {
                string matchGroupValue = matchResults[i].Groups[1].Value;
                string tmpStr = RemoveSmallBracketContent(matchGroupValue);
                bool ret = tmpStr.Contains(",");
                if (!ret)
                {
                    matchGroupValue = AddBackSlashToKey(matchGroupValue);
                    pattern = string.Format(@"(\W){0}\s*\(({1})\)", dataType, matchGroupValue);
                    string replacement = string.Format("$1{0}($2, $2, $2)", dataType);
                    if (dataType.Contains("2"))
                    {
                        replacement = string.Format("$1{0}($2, $2)", dataType);
                    }
                    else if (dataType.Contains("3"))
                    {
                        replacement = string.Format("$1{0}($2, $2, $2)", dataType);
                    }
                    else if (dataType.Contains("4"))
                    {
                        replacement = string.Format("$1{0}($2, $2, $2, $2)", dataType);
                    }
                    inputShaderContent = Regex.Replace(inputShaderContent, pattern, replacement, RegexOptions.Singleline | RegexOptions.Multiline);
                }
            }

            return inputShaderContent;
        }

        public static string AddBackSlashToKey(string content)
        {
            content = content.Replace("(", @"\(");
            content = content.Replace(")", @"\)");
            content = content.Replace("[", @"\[");
            content = content.Replace("[", @"\[");
            content = content.Replace("{", @"\{");
            content = content.Replace("}", @"\}");
            content = content.Replace("+", @"\+");
            content = content.Replace("*", @"\*");
            content = content.Replace("?", @"\?");
            content = content.Replace(".", @"\.");
            content = content.Replace("|", @"\|");

            return content;
        }

        public static string ReplaceVectorMultiply(string inputShaderContent)
        {
            // Replace *= with mul();
            MatchCollection matchResults = Regex.Matches(inputShaderContent, @"([^\s]+\s*)\*\=\s*([^;]+)");
            for (int i=0; i<matchResults.Count; ++i)
            {
                string matchResult = matchResults[i].Value;
                string var1 = matchResults[i].Groups[1].Value;
                var1 = AddBackSlashToKey(var1);
                string var2 = matchResults[i].Groups[2].Value;
                var2 = AddBackSlashToKey(var2);
                string pattern = string.Format(@" (float2|float3|float4|half2|half3|half4|fixed2|fixed3|fixed4|float2x2|float3x3|float4x4)\s+{0}\W", var1);
                Match varMatchResult1 = Regex.Match(inputShaderContent, pattern);
                pattern = string.Format(@" (float2|float3|float4|half2|half3|half4|fixed2|fixed3|fixed4|float2x2|float3x3|float4x4)\s+{0}\W", var2);
                Match varMatchResult2 = Regex.Match(inputShaderContent, pattern);
                if (!string.IsNullOrEmpty(varMatchResult1.Value) && !string.IsNullOrEmpty(varMatchResult2.Value))
                {
                    matchResult = AddBackSlashToKey(matchResult);
                    pattern = string.Format(@"{0}", matchResult);
                    string replacement = string.Format("{0} = mul({0}, {1})", var1, var2);
                    inputShaderContent = Regex.Replace(inputShaderContent, pattern, replacement);
                }
            }

            // Replace * with mul();
            matchResults = Regex.Matches(inputShaderContent, @"(\w+)\s*\*\s*(\w+)");
            for (int i = 0; i < matchResults.Count; ++i)
            {
                string matchResult = matchResults[i].Value;
                string var1 = matchResults[i].Groups[1].Value;
                var1 = AddBackSlashToKey(var1);
                string var2 = matchResults[i].Groups[2].Value;
                var2 = AddBackSlashToKey(var2);
                string pattern = string.Format(@" (float2|float3|float4|half2|half3|half4|fixed2|fixed3|fixed4|float2x2|float3x3|float4x4)\s+{0}[; =]", var1);
                Match varMatchResult1 = Regex.Match(inputShaderContent, pattern);
                pattern = string.Format(@" (float2|float3|float4|half2|half3|half4|fixed2|fixed3|fixed4|float2x2|float3x3|float4x4)\s+{0}[; =]", var2);
                Match varMatchResult2 = Regex.Match(inputShaderContent, pattern);
                if (!string.IsNullOrEmpty(varMatchResult1.Value) && !string.IsNullOrEmpty(varMatchResult2.Value))
                {
                    matchResult = AddBackSlashToKey(matchResult);
                    pattern = string.Format(@"{0}", matchResult);
                    string replacement = string.Format("mul({0}, {1})", var1, var2);
                    inputShaderContent = Regex.Replace(inputShaderContent, pattern, replacement);
                }
            }

            return inputShaderContent;
        }

        public static string ReplaceVectorMultiply2(string inputShaderContent)
        {
            // Replace *= with mul();
            inputShaderContent = Regex.Replace(inputShaderContent, @"([^\s]+\s*)\*\=\s*([^;]+)", "$1 = mul($1, $2);");

            // Replace * with mul();
            inputShaderContent = Regex.Replace(inputShaderContent, @"([a-zA-Z0-9_\.]+)\s*\*\s*([a-zA-Z0-9_\.]+)", "mul($1, $2)");

            return inputShaderContent;
        }
    }
}
