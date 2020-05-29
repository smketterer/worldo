/// @desc Get nearest resource of type that someone else isn't working on.
/// @arg object Object class to get.
/// @arg ignore_stored Ignore objects in storage.
/// @arg designated_only Only look for designated objects.
function get_closest_unclaimed_resource(_object) {
	var objects = ds_list_create()
	with (_object) {
		if argument_count > 1 and argument[1] and stored {
			continue
		}
		if not claimed and !(argument_count > 2 and argument[2] and !designated) {
			ds_list_add(objects, self);
		}
	}

	if ds_list_size(objects) > 0 {
		var min_distance = 100000
		var min_distance_object
		for (var i=0; i<ds_list_size(objects); i++) {
			var instance = ds_list_find_value(objects, i)
			var distance = distance_to_point(instance.x, instance.y)
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
}


function get_closest_enemy() {
	var enemy_list = ds_list_create()
	var my_faction = faction

	with Person {
		if faction != my_faction {
			ds_list_add(enemy_list, self)
		}
	}

	if ds_list_size(enemy_list) > 0 {
		var min_distance = 100000
		var min_distance_object
		for (var i=0; i<ds_list_size(enemy_list); i++) {
			var instance = ds_list_find_value(enemy_list, i)
			var distance = distance_to_point(instance.x, instance.y)
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
}
