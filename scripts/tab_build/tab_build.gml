Manager.cursor_mode = "build"
set_active_panel("Build objects")
Manager.active_blueprint = noone

var items = [WoodWall, Lamp, Couch, Floor]

for (var i=0; i<array_length_1d(items); i++) {
	var button = instance_create_layer(0,0,layer,BuildItemButton)
	button.text = "Build " + string(get_object_name(items[i]))
	button.item = items[i]
	button.i = i
	button.script = button_build_item
}