/// @description Autowar debug

with (Worker) {
	if !selected { continue }
	queue_add("DEFEND")
}