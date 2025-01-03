Shader "Unlit/Lesson_01"
{
    // Properties are input data: https://docs.unity3d.com/Manual/SL-Properties.html
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {} // => "white" is a unity built-in texture. same as "black", "gray", "bump" or "red". if no default value is given it defaults to "gray" on it's own
        _ExampleInteger ("Example Integer", Integer) = 0
        _ExampleFloat ("Example Float", Float) = 0.5
        _ExampleFloat_Range ("Example Float With Range", Range(0.0, 0.5)) = 0.25 
        _ExampleColor("Example Color", Color) = (.25, .5, .5, 1)
        _ExampleVector("Example Vector", Vector) = (.25, .5, .5, 1) // Vector is a vec4 
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        // Level Of Detail. Not necessary, can be removed, but let's keep it for the sake of explanation.
        LOD 100

        Pass
        {
            /* 
                All the CG strings and refs are coming from the time when Unity was using CG, as it's shader language: 
                https://en.wikipedia.org/wiki/Cg_%28programming_language%29
           
                It is interesting bc it says that Cg and HLSL are are just 2 different names for a high-level shading language developed by Nvidia and Microsoft
                Which as always has caveats. There was a branching at some point, but generally speaking Cg is deprecated. HLSL outputs DirectX shaders in bytecode format.
            */
            
            CGPROGRAM
            #pragma vertex vert // <== I want my vertex shader to be a function called 'vert'
            #pragma fragment frag // <== I want my fragment shader to be a function called 'frag'

            // This instruction takes the contents of the UnityCG.cginc file and pastes it here. It's a collection of built-in Unity related
            // functions which are handy and should be used here.
            #include "UnityCG.cginc"

            // Here is where you define all your read-only variables (uniforms). Every variable defined in 'Properties' needs to be duplicated here, so it can be used in the shader code.
            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct meshdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            // Actual vertex shader main func
            v2f vert(meshdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            // Actual fragment shader main func
            fixed4 frag(v2f i) : SV_Target
            {
                // fixed4 col = tex2D(_MainTex, i.uv);
                // return col;

                // Change all pixels to black
                return fixed4(.0, .0, .0, 1);
            }
            ENDCG
        }
    }
    
    // More here: https://docs.unity3d.com/Manual/shader-objects.html
    Fallback "Universal Render Pipeline/Unlit"
}
