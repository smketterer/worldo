/// @desc Get labels for tasks from task value.
/// @arg task

var task = argument0

switch (task) {
	case "DEFEND":
		return "Defending the base"
	case "DRAFT":
		return "Drafted"
	case "CHOP":
		return "Chopping wood"
	case "CUT":
		return "Foraging"
	case "HAUL":
		return "Hauling items"
	case "BUILD":
		return "Building items"
	default:
		return "Idle"
}