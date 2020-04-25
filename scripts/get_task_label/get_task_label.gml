/// @desc Get labels for tasks from task value.
/// @arg task

var task = argument0

switch (task) {
	case "WAR":
		return "Drafted"
	case "CHOP":
		return "Chopping wood"
	default:
		return "Idle"
}