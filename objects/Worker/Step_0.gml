// shadow
polygon = polygon_from_instance(id);

switch (ds_priority_find_max(tasks)) {
	case "CHOP":
		chop_behaviour()
		break
	case "CUT":
		cut_behaviour()
		break
	case "HAUL":
		haul_behaviour()
		break
	case "WAR":
		break
	case "DEFEND":
		defend_behaviour()
	default:
		break
}