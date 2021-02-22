function build_behaviour() {
	var instance = self
	var resources = ds_list_create()
	with Resource {
		if claimed_by == instance {
			claimed = true
			claimed_by = instance
			ds_list_add(resources, self)
		}
	}

	if ds_list_size(resources) == 0 and hauling == noone {
		// Get closest blueprint and required resources
		refresh_grid()
		var closest = get_closest_unclaimed_resource(Blueprint)
	
		if closest {
			refresh_grid()
			var requirement = get_closest_unclaimed_resource(closest.requirement)
		
			closest.claimed = true
			closest.claimed_by = self
			if requirement {
				requirement.claimed = true
				requirement.claimed_by = self
				move_to(requirement.x, requirement.y)
			}
		} else {
			// No resources left, cancel
			queue_pop()
		}
	} else if !hauling {
		// Hauling requirement to blueprint
		for (var i=0; i<ds_list_size(resources); i++) {
			var resource = ds_list_find_value(resources,i)
			if resource.object_index != Blueprint {
				if path_position == 1 {
					// @TODO: Double check distance here.
					resource.work -= ((hauling_skill / 10) * Manager.timescale)
					if resource.work <= 0 {
						for (var i=0; i<ds_list_size(resources); i++) {
							var resource2 = ds_list_find_value(resources,i)
							if resource2.object_index == Blueprint {
								hauling_to = [resource2.x, resource2.y]
								move_to(resource2.x, resource2.y)
							}
						}
						if resource.stored {
							var zone = instance_position(resource.x,resource.y,Zone)
							zone.claimed = false
						}
					}
				}
			}
			if ds_list_size(resources) <= 1 {
				// Only a blueprint, no resources
				queue_pop()
			}
		}
	} else if hauling {
		// Is hauling item, place on blueprint and begin work
		hauling.x = x
		hauling.y = y
	
		if path_position == 1 {
			// Place resources
			var placed_resource = noone
			for (var i=0; i<ds_list_size(resources); i++) {
				var resource = ds_list_find_value(resources,i)
				if resource.object_index != Blueprint {
					placed_resource = resource
					resource.stored = true
					hauling.x = hauling_to[0]
					hauling.y = hauling_to[1]
				}
			}
			// Next to resource, build it.
			if path_position == 1 {
				resource.work -= ((building_skill / 10) * Manager.timescale)
				if resource.work <= 0 {
					with placed_resource {
						instance_destroy()
					}
					reset_resource_claims()
				}
			}
		}
	}
}

function chop_behaviour() {
	var instance = self
	var resource = noone
	with Resource {
		if claimed_by == instance {
			claimed = true
			claimed_by = instance
			resource = self
		}
	}
	if !resource {
		// No resource, find closest unclaimed tree
		refresh_grid()
		var closest = get_closest_unclaimed_resource(Tree, false, true)
		if closest {
			move_to(closest.x, closest.y)
			closest.claimed = true
			closest.claimed_by = self
		} else {
			// No resources left, cancel
			queue_pop()
		}
	} else {
		// Next to tree, cut it.
		if path_position == 1 {
			resource.hp -= ((chopping_skill / 10) * Manager.timescale)
		}
	}
}

function cut_behaviour() {
	var instance = self
	var resource = noone
	with Resource {
		if claimed_by == instance {
			claimed = true
			claimed_by = instance
			resource = self
		}
	}
	if !resource {
		// No resource, find closest unclaimed bush
		refresh_grid()
		var closest = get_closest_unclaimed_resource(Bush, false, true)
		if closest {
			move_to(closest.x, closest.y)
			closest.claimed = true
			closest.claimed_by = self
		} else {
			// No resources left, cancel
			queue_pop()
		}
	} else {
		// Next to resource, cut it.
		if path_position == 1 {
			resource.hp -= ((cutting_skill / 10) * Manager.timescale)
		}
	}
}

function defend_behaviour() {
	if !target or !instance_exists(target) or path_get_number(path) <= 2 {
		// No target, find closest enemy
		refresh_grid()
		var closest = get_closest_enemy()
		target = closest
		firing = false
		aiming = false
	
		if closest {
			var closest_end_x = x
			var closest_end_y = x
		
			// Move to end of closest path
			if (closest.path) {
				closest_end_x = path_get_point_x(closest.path,path_get_number(closest.path)-1)
				closest_end_y = path_get_point_y(closest.path,path_get_number(closest.path)-1)
			}

			var closest_direction = point_direction(x,y,closest.x,closest.y)
			var closest_distance = point_distance(x,y,closest.x,closest.y)
			var distances = [5/6, 4/5, 3/4, 1/2, 1/4, 0]
		
			for (var i=0; i<array_length_1d(distances); i++) {
				var to_x = lengthdir_x(closest_distance + (closest_distance*-distances[i]), closest_direction)
				var to_y = lengthdir_y(closest_distance + (closest_distance*-distances[i]), closest_direction)
				move_to(x+to_x, y+to_y)
			
				if path and !collision_line(x+to_x, y+to_y, target.x, target.y, Block, true, true) {
					break
				}
			}
		} else {
			// No enemies left, cancel
			queue_pop()
			target = noone
			move_to(x,y)
		
			if dir == 1 {
				direction = 0
				aim_dir = direction
			} else {
				direction = 180
				aim_dir = direction
			}
		}
	} else {
		// Check whether you're close enough to fire.
		if path and path_position == 1 {
			if collision_line(x,y,target.x,target.y,Block,true,true) {
				target = noone
			}
			aiming = true
			if attack_counter > 0 {
				firing = false
				attack_counter -= Manager.timescale
			} else {
				firing = true
				attack_counter = attack_cooldown
			}
		}
	}
}

function eat_behaviour() {
	var instance = self
	var resource = noone
	with Resource {
		if claimed_by == instance {
			claimed = true
			claimed_by = instance
			resource = self
		}
	}
	if !resource {
		// No resource, find closest unclaimed tree
		refresh_grid()
		var closest = get_closest_unclaimed_resource(Berries)
		if closest {
			move_to(closest.x, closest.y)
			closest.claimed = true
			closest.claimed_by = self
		} else {
			// No resources left, cancel
			queue_pop()
		}
	} else {
		// Next to berries, eat them.
		if path_position == 1 {
			resource.hp -= (.25 * Manager.timescale)
			hunger += (.25 * resource.nutrition * Manager.timescale)
			hauling = resource
			hauling.x = x
			hauling.y = y
		
			if hunger >= 100 {
				// drop current food, stop eating
				var zone = instance_place(x,y,Zone)
				reset_resource_claims()
				if (zone) {
					zone.claimed = true
					zone.claimed_by = resource
				}
				queue_pop()
			}
		}
	}
}

function haul_behaviour() {
	var instance = self
	var resource = noone

	with Resource {
		if claimed_by == instance {
			claimed = true
			claimed_by = instance
			resource = self
		}
	}

	var is_zone = get_closest_unclaimed_resource(Zone)
	if !is_zone and !resource {
		queue_pop()
		exit
	}

	if !resource and hauling == noone {
		// No resource, find closest unclaimed storable item
		refresh_grid()
		var closest = get_closest_unclaimed_resource(Storable, true)
		if closest {
			move_to(closest.x, closest.y)
			closest.claimed = true
			closest.claimed_by = self
		} else {
			// No resources left, cancel
			queue_pop()
		}
	} else if hauling == noone {
		// Next to resource, carry it.
		if path_position == 1 {
			resource.work -= ((hauling_skill / 10) * Manager.timescale)
			if resource.work <= 0 {
				var closest = get_closest_unclaimed_resource(Zone)
				if closest {
					hauling_to = [closest.x, closest.y]
					move_to(closest.x, closest.y)
					closest.claimed = true
					closest.claimed_by = self
				} else {
					// No resources left, cancel
					queue_pop()
				}
			}
		}
	} else {
		// Is hauling item, place in stockpile
		hauling.x = x
		hauling.y = y
	
		if path_position == 1 {
			resource.stored = true
			hauling.x = hauling_to[0]
			hauling.y = hauling_to[1]
		
			var zone = instance_place(hauling_to[0],hauling_to[1],Zone)
			reset_resource_claims()
			zone.claimed = true
			zone.claimed_by = resource
		}
	}
}
	
function sleep_behaviour() {
	sleep += (.0075 * Manager.timescale)
	
	if sleep >= 85 {
		queue_pop()
	}
}