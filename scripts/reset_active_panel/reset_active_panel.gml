active_panel = "none"
with BuildItemButton {
	instance_destroy()
}
with Tab {
	if variable_instance_exists(self,"subtab") {
		instance_destroy()
	}
}