varying vec3 vColor;

void main()
{
    vec2 uv = gl_PointCoord;
    float distToCenter = length(uv-vec2(0.5));
    if(distToCenter>0.5)
        discard;
    gl_FragColor = vec4(vColor, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}