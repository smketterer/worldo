// Quick script to set depth = -y
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