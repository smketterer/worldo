var ai_state = argument0

switch ai_state {
	case "DEFEND":
		var any_enemies = false
		with (Person) {
			if variable_instance_exists(self,"faction") and faction != "player" {
				any_enemies = true
			}
		}
		return any_enemies
	case "CHOP":
		var any_trees = false
		with (Tree) {
			if designated and !claimed {
				any_trees = true
			}
		}
		return any_trees
	case "CUT":
		var any_bushes = false
		with (Bush) {
			if designated and !claimed {
				any_bushes = true
			}
		}
		return any_bushes
	case "HAUL":
		var any_storable = false
		var any_zones = false
		with (Storable) {
			any_storable = true
		}
		with (Zone) {
			if variable_instance_exists(self,"claimed") and !claimed {
				any_zones = true
			}
		}
		return any_storable && any_zones
	case "BUILD":
		var any_blueprint = false
		with (Blueprint) {
			if !claimed {
				with (requirement) {
					if !claimed {
						any_blueprint = true
					}
				}
			}
		}
		return any_blueprint
	case "EAT":
		var any_food = false
		with (Berries) {
			if !claimed {
				any_food = true
			}
		}
		return any_food
	default:
		return false
}