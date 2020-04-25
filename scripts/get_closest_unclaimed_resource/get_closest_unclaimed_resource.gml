/// @desc Get nearest resource of type that someone else isn't working on.
/// @arg object Object class to get.

var object = argument0

var from_x = x;
var from_y = y;

var objects = ds_list_create()
with (object) {
	if not claimed {
		ds_list_add(objects, self);
	}
}

if ds_list_size(objects) > 0 {
	var min_distance = 100000;
	var min_distance_object;
	for (var i=0; i<ds_list_size(objects); i++) {
		var instance = ds_list_find_value(objects, i)
		var distance = (instance.x - from_x) + (instance.y - from_y)
		if distance < min_distance {
			min_distance_object = instance
			min_distance = distance
		}
	}
	if (min_distance_object) {
		return min_distance_object
	} else {
		return false
	}
}