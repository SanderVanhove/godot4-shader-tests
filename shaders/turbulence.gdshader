shader_type canvas_item;

//Number of turbulence waves
uniform float TURB_NUM = 10.0;
//Turbulence wave amplitude
uniform float TURB_AMP = 0.7;
//Turbulence wave speed
uniform float TURB_SPEED = 0.3;
//Turbulence frequency
uniform float TURB_FREQ = 2.0;
//Turbulence frequency multiplier
uniform float TURB_EXP = 1.4;


void fragment() {
	vec2 uv = UV;

	//Turbulence starting scale
	float freq = TURB_FREQ;

	//Turbulence rotation matrix
	mat2 rot = mat2(vec2(0.6, -0.8), vec2(0.8, 0.6));

	//Loop through turbulence octaves
	for(float i=0.0; i<TURB_NUM; i++)
	{
	    //Scroll along the rotated y coordinate
	    float phase = freq * (uv * rot).y + TURB_SPEED * TIME + i;
	    //Add a perpendicular sine wave offset
	    uv += TURB_AMP * rot[0] * sin(phase) / freq;

	    //Rotate for the next octave
	    rot *= mat2(vec2(0.6, -0.8), vec2(0.8, 0.6));
	    //Scale down for the next octave
	    freq *= TURB_EXP;
	}

	COLOR = texture(TEXTURE, fract(uv));
}
