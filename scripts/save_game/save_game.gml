/// @desc Save file to JSON.
/// @arg filename
function save_game() {

	var filename = ""

	if argument_count == 0 {
		filename = "save.json"
	} else {
		filename = argument[0]
	}

	var json = save_instances()
	var file = file_text_open_write(filename)

	file_text_write_string(file, json)
	file_text_close(file)



}
