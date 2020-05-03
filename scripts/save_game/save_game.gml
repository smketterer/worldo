/// @arg filename

var filename = ""

if argument_count == 0 {
	filename = "save.dat"
} else {
	filename = argument[0]
}

with Entity {
	selected = false
}

game_save("save.dat")
log("game saved to " + filename)