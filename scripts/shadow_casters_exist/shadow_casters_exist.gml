/// @desc Gets whether any shadow casters exist
function shadow_casters_exist() {

	// Inline this script
	gml_pragma("forceinline");

	return instance_number(ShadowCaster) > 0;


}
