#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;

//円の距離函数
float circle(vec2 p)
{
	return length(p);
}

void main()
{
	vec2 p =(gl_FragCoord.xy * 2.0 - resolution)/min(resolution.x, resolution.y);

	float d = circle(p);
	vec3 color = vec3(d);
	gl_FragColor = vec4(color, 1.0);
}
