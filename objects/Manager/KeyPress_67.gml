/// @description Chop wood debug

with (Worker) {
	if !selected { continue }
	queue_add("CHOP")
	queue_add("CUT")
}