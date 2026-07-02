shader_type spatial;

uniform float progress: hint_range(0.0, 1.0) = 0.0;
// making a parameter named progress for us to manipulate in editor or script
// if all instances of a scene is getting shader change applied when they shouldn't, make sure
// 'Local to Scene' property in Resource tab is set
void fragment() {
	// Called for every pixel the material is visible on.
	// we only work on fragment for now
	ALPHA = progress;
	ALBEDO = vec3(1.0);
}
