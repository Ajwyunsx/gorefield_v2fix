#pragma header

uniform float time;
uniform float noiseIntensity;
uniform float colorOffsetIntensity;

const float range = 0.5;
const float noiseQuality = 250.0;

float rand(vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float verticalBar(float pos, float uvY, float offset)
{
    float edge0 = (pos - range);
    float edge1 = (pos + range);

    float x = smoothstep(edge0, pos, uvY) * offset;
    x -= smoothstep(pos, edge1, uvY) * offset;
    return x;
}

void main()
{
	vec2 uv = openfl_TextureCoordv.xy;
    
    for (float i = 0.0; i < 0.71; i += 0.1313)
    {
        float d = mod(time * i, 1.7);
        uv.x += verticalBar(d, uv.y, 0);
    }
    
    float uvY = uv.y;
    uvY *= noiseQuality;
    uvY = float(int(uvY)) * (1.0 / noiseQuality);
    float noise = rand(vec2(time * 0.00001, uvY));
    uv.x += noise * noiseIntensity;

    vec2 offsetR = vec2(0.006 * sin(time), 0.0) * colorOffsetIntensity;
    vec2 offsetG = vec2(0.0073 * (cos(time * 0.97)), 0.0) * colorOffsetIntensity;
    
    float r = flixel_texture2D(bitmap, uv + offsetR).r;
    float g = flixel_texture2D(bitmap, uv + offsetG).g;
    float b = flixel_texture2D(bitmap, uv).b;

    vec4 tex = vec4(r, g, b, flixel_texture2D(bitmap, uv));
    gl_FragColor = tex;
}