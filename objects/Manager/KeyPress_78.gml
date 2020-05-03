/// @description Build debug

with (Worker) {
	if !selected { continue }
	queue_add("BUILD")
}