precision mediump float;
varying vec2 v_tex_coord_camera;
varying vec2 v_tex_coord_ir;
uniform sampler2D s_baseMap;
uniform sampler2D s_irMap;

void main()
{
	const float PI = 3.1415926535897932384626433832795;

	vec4 baseColor;
	vec4 baseColorCorrected;
	float irColor;
	float r;

	baseColor = texture2D( s_baseMap, v_tex_coord_camera );
	baseColorCorrected = vec4(baseColor.b, baseColor.g, baseColor.r, baseColor.a);
	
	irColor = texture2D( s_irMap, v_tex_coord_ir ).r;
	float curve = -1.0 * ( cos( PI * irColor ) - 1.0 );
	float amp = sin( PI * irColor ) + 1.0;

	r =  curve * amp / 5.0;
	r = clamp(r, 0.0, 1.0);

	gl_FragColor = vec4(baseColorCorrected.r + r, baseColorCorrected.g - r, baseColorCorrected.b - r, 1.0);
}
