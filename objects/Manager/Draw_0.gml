if keyboard_check(vk_space) {
	draw_set_alpha(.25)
	mp_grid_draw(grid)
	draw_set_alpha(1)
}

var y_order = ds_grid_create(2,1)
var count = instance_number(Entity)
ds_grid_resize(y_order, 2, count)

var yy = 0; with Entity {
	y_order[# 0, yy] = id
	y_order[# 1, yy] = y
	yy++
}

ds_grid_sort(y_order, 1, true)

yy = 0; repeat(count) {
	var instance = y_order[# 0, yy]
	with (instance) {
		event_perform(ev_draw, 0)
	}
	yy++
}

ds_grid_destroy(y_order)

#region Day/night overlay
// See draw_shadow_map for the rest
draw_set_alpha(Manager.current_darkness / 1.25)
draw_rectangle_color(0,0,room_width,room_height,Manager.current_colour,Manager.current_colour,Manager.current_colour,Manager.current_colour,false)
draw_set_alpha(1)
draw_set_color(c_white)
#endregion