uniform vec2 uResolution;
uniform sampler2D uPicture;
varying vec3 vColor;
uniform sampler2D uDisplacementTexture;
attribute float aIntensity;
attribute float aAngle;

void main()
{
    // Displacement
    vec3 newPosition = position;
    float displacementIntensity = texture(uDisplacementTexture,uv).r;
   displacementIntensity = smoothstep(0.1,0.5,displacementIntensity);
    vec3 displacement = vec3(cos(aAngle)*0.4,sin(aAngle)*0.4,1.0);
    displacement = normalize(displacement);
    displacement*=displacementIntensity;
    displacement*=aIntensity;
    newPosition += displacement;
    // Final position
    vec4 modelPosition = modelMatrix * vec4(newPosition, 1.0);
    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;
    float pictureIntensity =  texture(uPicture,uv).r;
    // Point size
    gl_PointSize = pictureIntensity*0.1 * uResolution.y;
    gl_PointSize *= (1.0 / - viewPosition.z);
    // varyings
    vColor = vec3(pow(pictureIntensity,2.0)*uv.x,pictureIntensity*uv.y,pictureIntensity*0.8);
}