for (var i=0; i<2; i++) {
	// Find a free block
	var grid = Manager.grid
	var xx = round(random(room_width)/Manager.cellsize)
	var yy = round(random(room_height)/Manager.cellsize)
	while (mp_grid_get_cell(grid,xx,yy)) {
		xx = round(random(room_width)/Manager.cellsize)
		yy = round(random(room_height)/Manager.cellsize)
	}
	xx = xx*Manager.cellsize
	yy = yy*Manager.cellsize
	
	var person = instance_create_layer(xx,yy,"TopInstances",Person);
	
	var rand = random(1)
	if rand > .8 {
		person.sprite_index = char0
		person.sex = "male"
		person.first_name = get_name("fn_male")
		person.nickname = get_name("nn_male")
	} else if rand > .6 {
		person.sprite_index = char1
		person.sex = "female"
		person.first_name = get_name("fn_female")
		person.nickname = get_name("nn_female")
	} else if rand > .4 {
		person.sprite_index = char2
		person.sex = "male"
		person.first_name = get_name("fn_male")
		person.nickname = get_name("nn_male")
	} else if rand > .2 {
		person.sprite_index = char3
		person.sex = "female"
		person.first_name = get_name("fn_female")
		person.nickname = get_name("nn_female")
	} else {
		person.sprite_index = char5
		person.sex = "female"
		person.first_name = get_name("fn_female")
		person.nickname = get_name("nn_female")
	}
	
	person.name = person.first_name + " '" + person.nickname + "' " + person.last_name
}