/// @description Forage debug

with (Worker) {
	if !selected { continue }
	queue_add("CUT")
}