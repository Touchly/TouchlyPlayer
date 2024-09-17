using System.Runtime.InteropServices;
using System.Text;

namespace ReformSim
{
    static class ShaderConverterLib
    {
        const string m_dllName = "ShaderConverter.dll";

        [DllImport(m_dllName, CharSet = CharSet.Unicode, CallingConvention = CallingConvention.Cdecl)]
        public static extern int ConvertShaderFileToHlsl(string inputFilePathName, StringBuilder outputShaderContent, int outputShaderModel);

        [DllImport(m_dllName, CharSet = CharSet.Unicode, CallingConvention = CallingConvention.Cdecl)]
        public static extern int ConvertShaderToHlsl(string inputShaderContent, int inputShaderStage, StringBuilder outputShaderContent, int outputShaderModel);

        [DllImport(m_dllName, CharSet = CharSet.Unicode, CallingConvention = CallingConvention.Cdecl)]
        public static extern int ConvertShaderFileToHlslFile(string inputFilePathName, string outputFilePathName, int outputShaderModel);
    }
}
