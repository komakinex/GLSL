#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_res;
uniform vec2 u_mouse;
uniform float u_time;

float random(vec2 xy)
{
    return fract(sin(dot(xy.xy, vec2(12.98, 78.23)))*43758);
}

void main()
{
    vec2 xy = gl_FragCoord.xy / u_res.xy;

    float rnd = random(xy);

    gl_FragColor = vec4(vec3(rnd), 1.0);
}