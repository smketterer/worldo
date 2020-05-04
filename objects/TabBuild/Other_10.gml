Manager.cursor_mode = "build"
Manager.active_panel = "Build objects"
Manager.active_blueprint = noone

var items = [WoodWall, Lamp, Couch]

log(items)

for (var i=0; i<array_length_1d(items); i++) {
	var button = instance_create_layer(0,0,"Overlays",BuildItemButton)
	button.text = "Build " + string(get_object_name(items[i]))
	button.item = items[i]
	button.i = i
}
