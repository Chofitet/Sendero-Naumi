shader_type canvas_item;

uniform sampler2D border_texture : source_color;
uniform float border_size : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE.xy;
    vec4 original_color = texture(TEXTURE, uv);

    // Condición para aplicar la textura solo en el borde
    if (
        uv.x < border_size || uv.x > 1.0 - border_size ||
        uv.y < border_size || uv.y > 1.0 - border_size
    ) {
        // Escala la textura para que se repita en el borde
        vec2 scaled_uv = uv / border_size;

        // Mapea la textura del borde mezclando con el color original
        COLOR = mix(original_color, texture(border_texture, scaled_uv), 0.5);
    } else {
        COLOR = original_color;
    }
}

