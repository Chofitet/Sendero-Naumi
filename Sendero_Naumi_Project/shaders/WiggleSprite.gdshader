shader_type canvas_item;

uniform float squiggle_intensity : hint_range(0.0, 10.0) = 1.0; // Intensidad del efecto
uniform float speed : hint_range(0.0, 5.0) = 1.0; // Velocidad del efecto
uniform float frequency : hint_range(0.0, 20.0) = 10.0; // Frecuencia de las ondulaciones

void fragment() {
    vec2 uv = UV;

    // Añade una ondulación basada en el tiempo
    float time = TIME * speed;
    uv.x += sin(uv.y * frequency + time) * squiggle_intensity * 0.01;
    uv.y += cos(uv.x * frequency + time) * squiggle_intensity * 0.01;

    // Muestra la textura del sprite con las ondulaciones aplicadas
    COLOR = texture(TEXTURE, uv) * texture(TEXTURE, UV).a;
}