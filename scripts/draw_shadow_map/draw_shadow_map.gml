/// @desc Draws the composited shadow map
/// @arg x The X position at which to draw the shadow map
/// @arg y The Y position at which to draw the shadow map
function draw_shadow_map(argument0, argument1) {

	var X = argument0;
	var Y = argument1;
	var surface = global.worldShadowMap;

	//
	//	Set subtractive blend mode
	//
	gpu_set_blendmode(bm_subtract);

	//
	//	Subtract world light map from the shadow
	//
	shader_set(__WORLD_SHADOW_MAP_SHADER);

	// Shadow intensity
	// shader_set_uniform_f(global.u_AmbientShadow, global.ambientShadowIntensity);
	shader_set_uniform_f(global.u_AmbientShadow, Manager.current_darkness * 1.25); // @NOTE: Set to current darkness level
	shader_set_uniform_f_array(global.u_TexelSize_ShadowMap, [1.0 / surface_get_width(surface), 1.0 / surface_get_height(surface)]);

	//
	// Draw shadow map to the screen
	//
	draw_surface_ext(surface, X, Y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

	shader_reset();

	//
	//	Reset blend mode
	//
	gpu_set_blendmode(bm_normal);


}
