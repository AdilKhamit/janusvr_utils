﻿Shader "Hidden/ExposureShader"
{
	Properties
	{
		_InputTex("InputTex", 2D) = "White" {}
		_Exposure("Exposure", Float) = 0
	}
	SubShader
	{
		Cull Off
		Tags { "RenderType" = "Opaque" }
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex		: POSITION;
				float2 uv0			: TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex		: SV_POSITION;
				float2 uv0			: TEXCOORD0;
			};

			uniform sampler2D _InputTex;
			uniform float _Exposure;
			uniform float _IsLinear;

			v2f vert(appdata v)
			{
				v2f o;
				float2 inTexCoord = v.uv0;
				float2 screenPosTexCoord = float2(inTexCoord.x - 0.5f, -inTexCoord.y + 0.5f) * 2;
				o.vertex = float4(screenPosTexCoord, 0, 1);
				o.uv0 = v.uv0;

				return o;
			}

			float3 exposure(float3 color, float relative_fstop)
			{
				return color * pow(2.0, relative_fstop);
			}

			float4 frag(v2f i) : SV_Target
			{
				float3 lightmap = DecodeLightmap(tex2D(_InputTex, i.uv0));

				//return float4(pow(lightmap, 1 / 2.2), 1);
				if (_IsLinear > 0)
				{
					return float4(exposure(lightmap, _Exposure), 1);
				}
				else
				{
					return float4(lightmap, 1);
				}
			}
			ENDCG
		}
	}
}
