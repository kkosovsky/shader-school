Shader "Unlit/Lesson_02"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
            #include "Assets/Scenes/Helpers/ShaderUtils.hlsl"

            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct meshdata
            {
                float4 vertex : POSITION; // vertex coordinates

                float2 uv0 : TEXCOORD0; // koordynaty siatki uv || TEXCOORD0 is semantics. it takes UV 0
                float2 uv1 : TEXCOORD0; // uv1 coordinates

                float3 normals : NORMAL; // normal vectors for vertices. a normal is a vector explaining where a vertex is pointing
                float4 color : COLOR; // Vertex color
                float4 tangent : TANGENT; // Tangent (used for normal mapping), 4th component - W is a sign. whether it is flipped or not 
            };

            // name suggested by Freya
            struct interpolators
            {
                float4 vertex : SV_POSITION; // clip space position
                float2 uv : TEXCOORD0; // can be any data u want it to be, in this case it does not refer to UV channel, which is very confusing
                // float4 foo : TEXCOORD0; // any data u need
                // float4 bar : TEXCOORD0; // same here   
            };

            interpolators vert(meshdata v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex); // local space to clip space. but not so simple, there are steps to it. local space -> world space -> camera space ->  clip space
                o.uv = TRANSFORM_TEX(v.uv0, _MainTex);
                return o;
            }

            fixed4 get_color(interpolators i)
            {
                if (Compare(i.uv, float2(0.0, 0.0)))
                {
                    return fixed4(1.0, .0, .0, 1);
                }

                if (Compare(i.uv, float2(1.0, 1.0)))
                {
                    return fixed4(1.0, .0, .0, 1);
                }

                if (Compare(i.uv, float2(0.5, 0.5)))
                {
                    return fixed4(1.0, .0, .0, 1);
                }

                return fixed4(0.125, 0.211, 0.512, 1);
            }

            fixed4 frag(interpolators i) : SV_Target
            {
                return get_color(i);
            }

            ENDCG
        }
    }
}
