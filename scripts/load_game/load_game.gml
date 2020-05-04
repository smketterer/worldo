/// @desc Destroy saveable instances, and load new ones from JSON.
/// @arg filename

var filename = ""

if argument_count == 0 {
	filename = "save.json"
} else {
	filename = argument[0]
}

with all {
	if (ds_map_exists(global.save_map, object_index)) {
		// Exists in map, delete.
		instance_destroy(self,false)
	}
}

var json = ""
var file = file_text_open_read(filename)
while !file_text_eof(file) {
	json += file_text_readln(file)
}
file_text_close(file)

var m = json_decode(json)
var list = m[?"instances"]
for (var i=0; i<ds_list_size(list); i++) {
	var map = list[|i]
	save_map_get_instance(map)
}

with Entity {
	x = floor(x/Manager.cellsize)*Manager.cellsize
	y = floor(y/Manager.cellsize)*Manager.cellsize
}

with Person {
	moving = false
}

with Storable {
	layer_add_instance(initial_layer,self)
}

ds_map_destroy(m)