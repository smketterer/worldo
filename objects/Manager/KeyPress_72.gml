/// @description Hauling debug

with (Worker) {
	if !selected { continue }
	queue_add("HAUL")
}