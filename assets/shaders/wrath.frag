#pragma header

#define ANGLE 17.0

uniform vec3 uShadeColor;
uniform vec3 uOverlayColor;
uniform float uDistance;
uniform float uChoke;
uniform float uPower;

uniform float uDirection;
uniform float uOverlayOpacity;

uniform vec4 applyRect;

float blendLinearBurn(float base, float blend) {
	return max(base+blend-1.0,0.0);
}

vec3 blendLinearBurn(vec3 base, vec3 blend) {
	return max(base+blend-vec3(1.0),vec3(0.0));
}

vec3 blendLinearBurn(vec3 base, vec3 blend, float opacity) {
	return (blendLinearBurn(base, blend) * opacity + base * (1.0 - opacity));
}

float blendLinearDodge(float base, float blend) {
	return min(base+blend,1.0);
}

vec3 blendLinearDodge(vec3 base, vec3 blend) {
	return min(base+blend,vec3(1.0));
}

vec3 blendLinearDodge(vec3 base, vec3 blend, float opacity) {
	return (blendLinearDodge(base, blend) * opacity + base * (1.0 - opacity));
}

float blendLinearLight(float base, float blend) {
	return blend<0.5?blendLinearBurn(base,(2.0*blend)):blendLinearDodge(base,(2.0*(blend-0.5)));
}

vec3 blendLinearLight(vec3 base, vec3 blend) {
	return vec3(blendLinearLight(base.r,blend.r),blendLinearLight(base.g,blend.g),blendLinearLight(base.b,blend.b));
}

vec3 blendLinearLight(vec3 base, vec3 blend, float opacity) {
	return (blendLinearLight(base, blend) * opacity + base * (1.0 - opacity));
}

vec3 blendMultiply(vec3 base, vec3 blend) {
	return base*blend;
}

vec3 blendMultiply(vec3 base, vec3 blend, float opacity) {
	return blendMultiply(base.rgb, blend.rgb) * opacity + base.rgb * (1.0 - opacity);
}

float texture2DAlphaCheck(vec2 uv) {
	if(uv.x >= applyRect.x && uv.y >= applyRect.y && uv.x <= applyRect.z && uv.y <= applyRect.w) {
		return texture2D(bitmap, uv).a;
	} else {
		return 0.0;
	}
}

vec4 flixel_texture2DShaded(sampler2D bitmap, vec2 uv) {
	vec4 color = texture2D(bitmap, uv);

	if(color.a == 0.0){return vec4(0.0, 0.0, 0.0, 0.0);}

	if(uv.x >= applyRect.x && uv.y >= applyRect.y && uv.x <= applyRect.z && uv.y <= applyRect.w) {
		float fshading = 0.0;
		float acu = 0.0;

		float direction = radians(mod(uDirection + 90.0, 360.0));
		vec2 diro = uChoke * vec2(cos(direction), sin(direction));

		for(float i = 0.0; i <= 360.0; i += ANGLE) {
			vec2 offo = uDistance * vec2(cos(radians(i)), sin(radians(i)));

			//for(float power = 0.15; power <= 1.0; power += 0.15) {
			float power = 0.5;
				vec2 off = power * offo + diro;

				float alpha = texture2DAlphaCheck(uv - off/openfl_TextureSize.xy);
				fshading += power * (1.0 - alpha);
				acu += power;
			//}
		}

		fshading /= acu;

		//fshading *= color.a; // Fix the overly green on transparent // BUG: Broken edges

		vec3 shading = (fshading) * uShadeColor;

		vec3 finalColor = blendMultiply(
			color.rgb +
				uPower * blendLinearLight(shading.rgb, color.rgb, (1.0 - color.a)),
			uOverlayColor, uOverlayOpacity
		);

		color = vec4(finalColor, color.a);
	} else {
		color = color;
	}

	if(!hasTransform){return color;}

	if(color.a == 0.0){return vec4(0.0, 0.0, 0.0, 0.0);}

	if(!hasColorTransform){return color * openfl_Alphav;}

	color = vec4(color.rgb / color.a, color.a);

	mat4 colorMultiplier = mat4(0);
	colorMultiplier[0][0] = openfl_ColorMultiplierv.x;
	colorMultiplier[1][1] = openfl_ColorMultiplierv.y;
	colorMultiplier[2][2] = openfl_ColorMultiplierv.z;
	colorMultiplier[3][3] = openfl_ColorMultiplierv.w;

	color = clamp(openfl_ColorOffsetv + (color * colorMultiplier), 0.0, 1.0);

	if(color.a > 0.0){
		return vec4(color.rgb * color.a * openfl_Alphav, color.a * openfl_Alphav);
	}
	return vec4(0.0, 0.0, 0.0, 0.0);
}

void main() {
	vec2 uv = openfl_TextureCoordv.xy;
	vec2 fragCoord = uv * openfl_TextureSize.xy;

	vec4 color = flixel_texture2DShaded(bitmap, uv);

	gl_FragColor = color;
}