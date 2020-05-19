with BuildItemButton {
	instance_destroy()
}
with Tab {
	if variable_instance_exists(self,"subtab") {
		instance_destroy()
	}
}

if argument0 == "Inspecting" and (Manager.inspecting.object_index == Person or object_is_ancestor(Manager.inspecting.object_index,Person)) {
	var tabs = ["Needs", "Social", "Bio"]

	for (var i=0; i<array_length_1d(tabs); i++) {
		var button = instance_create_layer(0+(64*i),window_get_height()-Manager.tab_height+66,"Overlays",Tab)
		button.text = tabs[i]
		button.subtab = true
		switch i {
			case 0:
				button.script = tab_needs
				continue
			case 1:
				button.script = tab_social
				continue
			case 2:
				button.script = tab_bio
				continue
		}
	}
}

Manager.active_panel = argument0