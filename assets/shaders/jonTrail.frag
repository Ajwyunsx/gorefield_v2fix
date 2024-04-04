// SHADER BY BBPANZU THANK YOU!!1111
#pragma header

// GAUSSIAN BLUR SETTINGS
uniform float dim;
float directions = 8.0;
float quality = 4;
//float directions = 16;
//float quality = 10;
uniform float size; 
uniform float sat;

mat4 saturationMatrix( float saturation )
{
    vec3 luminance = vec3( 0.3086, 0.6094, 0.0820 );
    
    float oneMinusSat = 1.0 - saturation;
    
    vec3 red = vec3( luminance.x * oneMinusSat );
    red+= vec3( saturation, 0, 0 );
    
    vec3 green = vec3( luminance.y * oneMinusSat );
    green += vec3( 0, saturation, 0 );
    
    vec3 blue = vec3( luminance.z * oneMinusSat );
    blue += vec3( 0, 0, saturation );
    
    return mat4( red,     0,
                 green,   0,
                 blue,    0,
                 0, 0, 0, 1 );
}

void main(void)
{ 
    vec2 uv = openfl_TextureCoordv.xy;

    float Pi = 6.28318530718; // Pi*2

    vec4 Color = texture2D( bitmap, uv);

	float aaply = 0.0;

    for(float d=0.0; d<Pi; d+=Pi/directions){
        for(float i=1.0/quality; i<=1.0; i+=1.0/quality){

            float ex = (cos(d)*size*i)/openfl_TextureSize.x;
            float why = (sin(d)*size*i)/openfl_TextureSize.y;
            Color += flixel_texture2D( bitmap, uv+vec2(ex,why));
			aaply += dim;
        }
    }

    Color /= max(aaply - (directions - 1.0), 1);//(dim * quality) * directions - (directions - 1.0);
    vec4 bloom =  (flixel_texture2D( bitmap, uv)/ dim)+Color;

    gl_FragColor = saturationMatrix(sat) * bloom;
}