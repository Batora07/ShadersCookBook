Shader "CookbookShaders/RadiusShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Center("Center", Vector) = (200,0,200,0)
		
		_Radius("Radius", Float) = 0.5
		_RadiusColor("Radius Color", Color) = (1,1,1,1)
		_RadiusWidth("Radius Width", Float) = 10
	}
	SubShader {
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		
		#pragma surface surf Standard 

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex; // the UV of the terrain texture
			float3 worldPos; // the in-world position
		};
	
	//	fixed4 _Color;
		float3 _Center;
		float _Radius;
		fixed4 _RadiusColor;
		float _RadiusWidth;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Get the distance between the center of the 
			// place we wish to draw from and the input's 
			// world position
			float d = distance(_Center, IN.worldPos);

			// if the distance is larger than the radius and
			// it is less than our radius + width change the color
			if ((d > _Radius) && (d < (_Radius + _RadiusWidth))) {
				o.Albedo = _RadiusColor;
			}
			// otherwise, use the normal color
			else {
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			}
		}
		ENDCG
	}
	FallBack "Diffuse"
}
