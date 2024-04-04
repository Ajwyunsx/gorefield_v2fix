#pragma header

#define FALLING_SPEED  0.2
#define STRIPES_FACTOR .4
#define ZOOM_FACTOR 1
#define TRANSPARENCY 6.

uniform float time;
uniform vec2 res;

//get sphere
float sphere(vec2 coord, vec2 pos, float r) {
    vec2 d = pos - coord; 
    d *=vec2(1.0/ZOOM_FACTOR, 1.0/ZOOM_FACTOR);
    return smoothstep(60.0, 0.0, dot(d, d) - r * r);
}

//main
void main()
{
    //normalize pixel coordinates
    vec2 nuv         = openfl_TextureCoordv.xy;
    vec2 uv = nuv * vec2(1.0/ZOOM_FACTOR, 1.0/ZOOM_FACTOR);
    //pixellize uv
    vec2 clamped_uv = ((openfl_TextureCoordv*res / STRIPES_FACTOR) * STRIPES_FACTOR) / (res.xy);
    //get pseudo-random value for stripe height
    float value        = fract(sin(clamped_uv.x) * 43758.5453123);
    //create stripes
    vec3 col        = vec3(1.0 - mod(uv.y * 0.5 + (time * (FALLING_SPEED + value / 5.0)) + value, 0.5));
    //add color
         col       *= clamp(cos(time * 2.0 + uv.xyx + vec3(0, 2, 4)), 0.0, 1.0);
    //fade rainbow shit
         col *= 0.7;
    //add glowing ends
         col        += vec3(sphere(openfl_TextureCoordv*res, 
                                  vec2(clamped_uv.x, (1.0 - 2.0 * mod((time * (FALLING_SPEED + value / 5.0)) + value, 0.5))) * res.xy, 
                                  0.9)) / 2.0; 
    //fade rainbow shit
         col *= 0.8;
    //add screen fade
         col       *= vec3(exp(-pow(abs(nuv.y - 0.5), 6.0) / pow(2.0 * 0.05, 2.0)));
         
    // Output to screen
    gl_FragColor       = flixel_texture2D(bitmap,nuv) + (vec4(col,1.0) * TRANSPARENCY);
}