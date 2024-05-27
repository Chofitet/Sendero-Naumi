shader_type canvas_item;

uniform vec2 blur_amount = vec2(0.01, 0.01);
uniform vec2 focus_point = vec2(0.5, 0.5);

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform sampler2D texture3;
uniform sampler2D texture4;
uniform sampler2D texture5;
uniform sampler2D texture6;

uniform float focus_radius = 0.1;
uniform bool ColorBackground;
uniform vec4 BackgroundColor : source_color;
uniform bool TransparentBackground;
uniform bool DrawTransparent;
uniform float xOffset;
uniform float yOffset;

void fragment() {
	vec2 floatVector = vec2(textureSize(TEXTURE,0));
	
	vec2 normalizedUV = UV / floatVector;
	float aspectRatio = floatVector.x / floatVector.y;
	
	float normalizedRadius = focus_radius / max(floatVector.x, floatVector.y) * aspectRatio;
	vec2 normalizedFocusPoint = focus_point / floatVector;
	float adjustedDistance = distance(normalizedFocusPoint, normalizedUV * vec2(1.0, aspectRatio));
	
	vec4 color = texture(TEXTURE, UV);
	vec4 color_up = texture(TEXTURE, UV + vec2(0.0, blur_amount.y));
	vec4 color_down = texture(TEXTURE, UV + vec2(0.0, -blur_amount.y));
	vec4 color_left = texture(TEXTURE, UV + vec2(-blur_amount.x, 0.0));
	vec4 color_right = texture(TEXTURE, UV + vec2(blur_amount.x, 0.0));

	if(adjustedDistance < normalizedRadius ) {
		if (DrawTransparent)
		{
			COLOR = vec4(0,0,0,0);
		}
		else{
			COLOR = color;
		}
	}
	else {
		
		if (ColorBackground)
		{
			COLOR = BackgroundColor;
		}
		else if (TransparentBackground)
		{
			COLOR = color * vec4(1,1,1,0.3);
		}
		else{
			COLOR = (color_up + color_down + color_left + color_right) / 4.0;
		}
		
	}
	
}