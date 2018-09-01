Shader "CookbookShaders/Silhouette" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_DotProduct ("Rim effect", Range(-1,1)) = 0.25
	}
	SubShader {
		Tags { 
			"Queue"="Transparent"
			"IgnoreProjector"="True"
			"RenderType"="Transparent"
		}
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert alpha:fade NoLighting

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldNormal;
			float3 viewDir;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		float _DotProduct;

		void surf (Input IN, inout SurfaceOutput o) {
			float4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;

			float border = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
			float alpha = (border * (1 - _DotProduct) + _DotProduct);
			o.Alpha = c.a * alpha;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
