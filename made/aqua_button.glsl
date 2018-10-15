precision mediump float;
uniform vec2  m;       // mouse
uniform float t;       // time
uniform vec2  r;       // resolution
uniform sampler2D smp; // prev scene

#define saturate(x) clamp(x,0.,1.)

float fill(float l,float d){return smoothstep(0.,0.01,d-l);}
float stroke(float l,float d,float w){return 1.-smoothstep(w*.5,w*.5+0.01,abs(d-l));}
float shadow(float l,float d,float w){float m = smoothstep(w,w+0.01,abs(d-l));return 1.-saturate(abs(d-l)*(d/w)*(1.-m)) - m;}
float shadowInner(float l,float d,float w){return shadow(l,d,w)*smoothstep(0.,0.01,d-l);}
float shadowOuter(float l,float d,float w){return shadow(l,d,w)*smoothstep(d-l,d-l+0.01,0.);}
float strokeInner(float l,float d,float w){return stroke(l,d-w*.5,w);}
float strokeOuter(float l,float d,float w){return stroke(l,d+w*.5,w);}

void main(void){
    vec3 color=vec3(0.);
    vec2 p = (gl_FragCoord.xy * 2.0 - r) / min(r.x, r.y);
    float l=0.;
    l    += fill(length(p),1.)*(1.2-length(p-vec2(0.,1.))*.5);
    l     = mix(l,1.2-length(p-vec2(0.,-.9))*.5,fill(length(p),.9));
    color = vec3(l);
    color = mix(
        color,
        mix(
            vec3(0.1,0.3,1.),
            vec3(0.4,0.8,1.),
            1.3-length(p-vec2(0.,-.8))
        )
        ,fill(length(p),.88)
    );

    color = mix(color,vec3(0.),shadowInner(length(p),.88,.08));
    color = mix(color,vec3(1.),fill(length(p*vec2(.7,1.)+vec2(0.,-.48)),.4)*p.y);

    gl_FragColor = vec4(color, 1.0);
}
