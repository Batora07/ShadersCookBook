Shader "CookbookShaders/ch2_NormalMapShaders" {
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1,1,1,1)
		_NormalTex("Normal Map", 2D) = "bump" {}
		_NormalMapIntensity("Normal intensity", Range(0,1)) = 1
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _NormalTex;
		float4  _MainTint;
		fixed _NormalMapIntensity;

		struct Input {
			float2 uv_NormalTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// get the normal data out of the normal map texture
			// using the UnpackNormal function
			fixed3 n = UnpackNormal(tex2D(_NormalTex, IN.uv_ _NormalTex)).rgb;
			n.x *= _NormalMapIntensity;
			n.y *= _NormalMapIntensity;
			o.Normal = normalize(n);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
