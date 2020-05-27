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
