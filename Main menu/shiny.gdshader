shader_type canvas_item;

uniform float move_duration : hint_range(0.1, 10.0) = 10.0;
uniform float idle_duration : hint_range(0.1, 20.0) = 1.0;
uniform vec4 line_color : source_color = vec4(1.0, 1.0, 0.5, 1.0);
uniform float line_width : hint_range(0.001, 0.2) = 0.02;

void fragment() {
    vec2 uv = UV;

    float total_period = move_duration + idle_duration;
    float t = mod(TIME, total_period);

    if (t < move_duration) {
        float progress = t / move_duration;

        //Line equation y = x + offset
        float offset = progress * 2.0 - 1.0;

        float dist = abs(uv.y - (uv.x + offset));

        // Smooth line edge
        float line_mask = smoothstep(line_width, line_width * 0.01, dist);

        float alpha = line_mask;

        COLOR = vec4(line_color.rgb, alpha * line_color.a);
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
