function evaluate_needs() {
	if sleep < 10 {
		if can_perform("SLEEP") {
			queue_add("SLEEP")
			return
		}
	}
	if hunger < 50 {
		if can_perform("EAT") {
			queue_add("EAT")
			return
		}
	}
}
