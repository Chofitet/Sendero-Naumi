shader_type canvas_item;

uniform sampler2D custom_texture;
uniform sampler2D mask_texture;
uniform float cutoff: hint_range(0, 1) = 1;
uniform float smoothness: hint_range(0, 1) = 0.1;
uniform bool inverted = false;

void fragment() {
	vec4 tex_color = texture(custom_texture, UV);
	float mask_value = texture(mask_texture, UV).r;
	
	if(inverted)
	{
		mask_value = 1.0 - mask_value;
	}
	
	float alpha = smoothstep(cutoff, cutoff + smoothness, mask_value * (1.0 - smoothness) + smoothness);
	// Multiplicamos la opacidad original con el valor de la máscara y el multiplicador
	COLOR = tex_color * vec4(1.0, 1.0, 1.0, alpha);
}