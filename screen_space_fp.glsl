#version 130

// Passed from the vertex shader
in vec2 uv0;

// Passed from outside
uniform float timer;
uniform float toggleSwitch;
uniform sampler2D texture_map;

void main() 
{
    // wavering
	
    vec2 pos = uv0;
	vec4 toAvg = vec4(0);
	float ofSamples = 0;

	
    //pos.x = pos.x + 0.05*(sin(timer*5.0+8.0*pos.y));
	//pos.y = pos.y + 0.05*(sin(timer*5.0+8.0*pos.x));


	if(toggleSwitch == 1){
	
		for(float x = -0.05; x < 0.05; x+=0.01){
			for(float y = -0.02; y < 0.02; y+=0.01){
			
				float newX = pos.x+x;
				float newY = pos.y+y;
				vec2 newPos = vec2(newX, newY);
				ofSamples++;

			
				vec4 pixel = texture(texture_map, newPos);
				toAvg+=pixel;
			}
		}
		toAvg /= ofSamples;
		gl_FragColor = toAvg;
	}
	else if(toggleSwitch == 2){
		pos*=2.0;
		vec4 pixel = texture(texture_map, pos);
		gl_FragColor = pixel;
	}
	else{
		toAvg = vec4(0);
		ofSamples = 0;
		float xLimits = 0.1;
		xLimits *= abs(sin(timer));
		float yLimits = 0.1;
		yLimits *= abs(sin(timer));

		for(float x = -xLimits; x < xLimits; x+=0.01){
			for(float y = -yLimits; y < yLimits; y+=0.01){
			
				float newX = pos.x+x;
				float newY = pos.y+y;
				vec2 newPos = vec2(newX, newY);
				ofSamples++;

				vec4 pixel = texture(texture_map, newPos);
				toAvg+=pixel;
			}
		}

		toAvg /= ofSamples;
		gl_FragColor = toAvg*sin(timer+1.57079632679) ;
	}
	
	//gl_FragColor = pos.y *vec4(1.0, 0.0, 0.0, 1.0) + toAvg;
}

