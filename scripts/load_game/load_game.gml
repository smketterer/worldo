/// @arg filename

var filename = ""

if argument_count == 0 {
	filename = "save.dat"
} else {
	filename = argument[0]
}

log("game loaded from " + filename)
game_load(filename)