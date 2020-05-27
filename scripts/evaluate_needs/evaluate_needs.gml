function evaluate_needs() {
	if hunger < 50 {
		if can_perform("EAT") {
			queue_add("EAT")
		}
	}


}
