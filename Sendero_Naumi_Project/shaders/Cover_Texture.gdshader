shader_type canvas_item;

//Alpha fade parameters
uniform sampler2D alpha_texture;
uniform float cutoff: hint_range(0, 1) = 1;
uniform float smoothness: hint_range(0, 1) = 0.1;
uniform bool inverted = false;

//Custom texture parameters 


uniform sampler2D NOISE_PATTERN1:repeat_enable;
uniform sampler2D NOISE_PATTERN2:repeat_enable;
uniform vec2 scroll1 = vec2(1.0, 0.4);
uniform vec2 scroll2 = vec2(0.2, 1.4);
uniform float speed : hint_range(0, 1) = 0.05;
uniform float xStretch = 1.0;
uniform float yStretch = 0.1;

uniform float laserSize : hint_range(0, 1) = 0.5;
uniform float wobbliness : hint_range(0, 1) = 0.1;

uniform vec4 color1 : source_color;
uniform vec4 color2 : source_color;
uniform float colorMixFactor : hint_range(0, 10) = 1;
uniform float glowFactor = 2.5;

uniform sampler2D TRANSPARENCY_VARIATION;
uniform float minAlpha = 0.3;

void vertex(){
	
}

void fragment() {
	//Alpha fade behaviour
	float value = texture(alpha_texture, UV).r;
	if (inverted) {
		value = 1.0 - value;
	}
	float alpha = smoothstep(cutoff, cutoff + smoothness, value * (1.0 - smoothness) + smoothness);
	
	
	//Texture Custom behaviour
	vec2 stretched_UV = UV;
	stretched_UV.x *= xStretch;
	stretched_UV.y *= yStretch;
	
	float intensity1 = textureLod(NOISE_PATTERN1, stretched_UV + TIME * scroll1 * speed, 0.0).r;
	float intensity2 = textureLod(NOISE_PATTERN2, stretched_UV + TIME * scroll2 * speed, 0.0).r;
	float intensity = intensity1 * intensity2;
	
	float centrality = (1.0 - abs(UV.y - 0.5)) * 0.5;
	
	if (wobbliness * intensity + (1.0 - wobbliness) * centrality > 1.0 - laserSize)
	{
		intensity *= centrality;
		vec4 color = mix(color1, color2, clamp(intensity * colorMixFactor, 0.0, 1.0)) * glowFactor;
		COLOR = vec4(color.rgb, alpha);
	}
	
}