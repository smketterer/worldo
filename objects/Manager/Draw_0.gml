if keyboard_check(vk_space) {
	draw_set_alpha(.25)
	mp_grid_draw(grid)
	draw_set_alpha(1)
}

#region Y-sorting
var y_order = ds_grid_create(2,1)
var count = instance_number(Entity)
ds_grid_resize(y_order, 2, count)

var yy = 0; with Entity {
	y_order[# 0, yy] = id
	y_order[# 1, yy] = y
	yy++
}

ds_grid_sort(y_order, 1, true)

// Render instances
yy = 0; repeat(count) {
	var instance = y_order[# 0, yy]
	with (instance) {
		if layer_get_name(layer) == "Instances" {
			event_perform(ev_draw, 0)
		}
	}
	yy++
}

#region Lighting rendering
// Update the shadow map
var exists;

if(dirty || tick >= global.lightUpdateFrameDelay || global.worldShadowMap == undefined || !surface_exists(global.worldShadowMap)) {
	// Composite shadow map
	exists = composite_shadow_map(global.worldLights);
	dirty = false;
	tick = 0;
}
else exists = surface_exists(global.worldShadowMap);

if(exists) {
	// Get the active camera
	var camera = lighting_get_active_camera();
	// Draw the shadow map
	draw_shadow_map(camera[eLightingCamera.X], camera[eLightingCamera.Y]);
}
#endregion

// Render top instances
yy = 0; repeat(count) {
	var instance = y_order[# 0, yy]
	with (instance) {
		if layer_get_name(layer) == "TopInstances" {
			event_perform(ev_draw, 0)
		}
	}
	yy++
}

ds_grid_destroy(y_order)
#endregion

#region Day/night overlay
// See draw_shadow_map for the rest
draw_set_alpha(Manager.current_darkness / 1.5)
draw_rectangle_color(0,0,room_width,room_height,Manager.current_colour,Manager.current_colour,Manager.current_colour,Manager.current_colour,false)
draw_set_alpha(1)
draw_set_color(c_white)
#endregion

#region Draw HUD elements
with (Entity) {
	gpu_set_blendmode(bm_add)
	if selected and object_is_ancestor(id.object_index, Movable) {
		draw_sprite_ext(select1, image_index, x+8, y+8, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	} else if selected {
		draw_sprite_part(select0, image_index,0,0,6,6,x-2,y-2)
		draw_sprite_part(select0, image_index,14,0,6,6,x+sprite_width-4,y-2)
		draw_sprite_part(select0, image_index,14,14,6,6,x+sprite_width-4,y+sprite_height-4)
		draw_sprite_part(select0, image_index,0,14,6,6,x-2,y+sprite_height-4)
	}
	gpu_set_blendmode(bm_normal)
}
#endregion