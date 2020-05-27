function reset_active_panel() {
	active_panel = "none"
	active_subpanel = "none"
	with BuildItemButton {
		instance_destroy()
	}
	with Tab {
		if variable_instance_exists(self,"subtab") {
			instance_destroy()
		}
	}


}
