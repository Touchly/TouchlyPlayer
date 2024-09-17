// Smallest positive number, such that 1.0 + FLT_EPSILON != 1.0
#define FLT_EPSILON 1.192092896e-07 

float3 PositivePow(float3 base, float3 power) {
    return pow(max(abs(base), float3(FLT_EPSILON, FLT_EPSILON, FLT_EPSILON)), power);
}

// sRGB/Linear
float3 SRGBToLinear(float3 c) {
    float3 LinearRGBLo  = c / 12.92;
    float3 LinearRGBHi  = PositivePow((c + 0.055) / 1.055, float3(2.4, 2.4, 2.4));
    float3 LinearRGB    = (c <= 0.04045) ? LinearRGBLo : LinearRGBHi;
    return LinearRGB;
}

float3 LinearToSRGB(float3 c) {
    float3 sRGBLo = c * 12.92;
    float3 sRGBHi = (PositivePow(c, float3(1.0/2.4, 1.0/2.4, 1.0/2.4)) * 1.055) - 0.055;
    float3 sRGB   = (c <= 0.0031308) ? sRGBLo : sRGBHi;
    return sRGB;
}

// 2D LUT
float3 ApplyLut2D(float3 base, sampler2D lutTex, float dim, bool inverseG = false) {
    float3 uvw = base;
        
    #if !defined(UNITY_COLORSPACE_GAMMA)
        uvw.rgb = LinearToSRGB(uvw);
    #endif
    
    // Inverse Green
    uvw.g = (1 - inverseG) * uvw.g + inverseG * (1 - uvw.g);
        
    // ApplyLut
    float3 scaleOffset = float3(1.0 / (dim*dim), 1.0 / dim, dim - 1);
    uvw.z *= scaleOffset.z;
    float shift = floor(uvw.z);
    uvw.xy = uvw.xy * scaleOffset.z * scaleOffset.xy + scaleOffset.xy * 0.5;
    uvw.x += shift * scaleOffset.y;
    
    float4 uv01 = float4(uvw, 0);
    uv01.xy += float2(scaleOffset.y, 0.0);
    
    uvw.xyz = lerp(
        tex2Dlod(lutTex, float4(uvw, 0)).rgb,
        tex2Dlod(lutTex, uv01).rgb,
        uvw.z - shift
    );
    
    #if !defined(UNITY_COLORSPACE_GAMMA)
        uvw.rgb = SRGBToLinear(uvw);
    #endif
    
    return uvw;
}

// 3D LUT
float3 ApplyLut3D(float3 base, sampler3D lutTex, float dim, bool inverseG = false) {
    float3 uvw = base;
        
    #if !defined(UNITY_COLORSPACE_GAMMA)
        uvw.rgb = LinearToSRGB(uvw);
    #endif
    
    // Inverse Green
    uvw.g = (1 - inverseG) * uvw.g + inverseG * (1 - uvw.g);
        
    // ApplyLut
    float2 scaleOffset = float2(1.0 / dim, dim - 1);
    uvw.xyz = uvw.xyz * scaleOffset.yyy * scaleOffset.xxx + scaleOffset.xxx * 0.5; 
    uvw = tex3Dlod(lutTex, float4(uvw, 0)).rgb;
    
    #if !defined(UNITY_COLORSPACE_GAMMA)
        uvw.rgb = SRGBToLinear(uvw);
    #endif
    
    return uvw;
}
