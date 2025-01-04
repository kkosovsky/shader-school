// float 32 bit float => good for world space
// half 16 bit float => used for most things. some platforms don't suppose half. supposedly used for mobile?
// fixed (legacy ~12 bit?) lower pres -> used for -1 to 1 range.

// float4 = Vector4 (32 bit flaot)
// float4x4 -> matrix
// bool -> 0 or 1
// int -> will prolly be converted to float anyway

Shader "Unlit/Lesson_02"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _Color;

            struct meshdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv0 : TEXCOORD0;
            };

            struct interpolators
            {
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD0;
                // float2 uv0 : TEXCOORD0;
            };

            interpolators vert(meshdata v)
            {
                interpolators output;
                output.vertex = UnityObjectToClipPos(v.vertex);
                output.normal = v.normal;
                // multiplying by the MVP (Model-View-Projection) matrix. From local space -> to global space -> to camera space -> to clip space
                return output;
            }

            // SV_Target => telling us this should output to the frame buffer
            fixed4 frag(interpolators input) : SV_Target
            {
                return float4(input.normal, 1);
            }

            void swizzlingExample()
            {
                // Swizzling
                float4 myValue;
                float2 otherValue = myValue.xy;
                float2 evenOtherValue = myValue.rg;
                float2 flipped = myValue.gr;
                float4 fourComp = myValue.xxxx;
            }
            ENDCG
        }
    }
}
