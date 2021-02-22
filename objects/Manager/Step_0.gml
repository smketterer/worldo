#region Day and night cycle
seconds += timescale * 2
minutes = seconds / 60
hours = minutes / 60

if hours >= 24 {
	seconds = 0
	day += 1
	if day > 30 {
		day = 1
		season += 1
	}
}

var current_phase = []
var next_phase = []
for (var i=0; i<array_length_1d(phase); i++) {
	if hours > array_get(phase[i],0) {
		current_phase = phase[i]
		if i == array_length_1d(phase)-1 {
			next_phase = phase[0]
		} else {
			next_phase = phase[i+1]
		}
	}
}
if array_length_1d(current_phase) == 0 {
	current_phase = phase[array_length_1d(phase)-1]
	next_phase = phase[0]
}
var phase_amount = (hours - array_get(current_phase,0)) / (array_get(next_phase,0) - array_get(current_phase,0))
if phase_amount > 1 {
	var phase_amount = (hours - array_get(current_phase,0)) / (array_get(next_phase,0) + 24 - array_get(current_phase,0))
}

current_colour = merge_color(array_get(current_phase,1),array_get(next_phase,1),phase_amount)
current_darkness = array_get(current_phase,2) - ((array_get(current_phase,2) - array_get(next_phase,2)) * phase_amount)
#endregion

#region Lighting tick
tick += 1;
#endregion

#region Time scaling and keys
if keyboard_check_pressed(vk_f12) {
	debug = !debug
	keyboard_string = ""
}

if keyboard_check_pressed(vk_escape) {
	if debug {
		debug = false
	} else {
		game_end()
	}
}

if debug {
	// keyboard shortcuts:
	caret_move = max(0, caret_move - 1)
	if (keyboard_check(vk_left) != keyboard_check(vk_right)) {
	  if (caret_move == 0) {
	    if (keyboard_check(vk_left)) {
	      if (caret > 0) caret -= 1
	    } else {
	      if (caret < string_length(text)) caret += 1
	    }
	      caret_move = caret_move_rate
	  }
	} else caret_move = 0
	if (keyboard_check_pressed(vk_home)) caret = 0
	if (keyboard_check_pressed(vk_end)) caret = string_length(text)
	if (keyboard_check_pressed(vk_delete)) {
	  text = string_delete(text, caret + 1, 1)
	}
	// actual input:
	if (keyboard_string != filltext && keyboard_string != "") {
	  var n, l, t;
	  t = keyboard_string
	  l = string_length(t)
	  n = 1
	  // find where actual input starts
	  while ((n <= l) && (string_char_at(t, n) == fillchar)) n += 1
	  c = 11 - n
	  if (c > 0 && caret > 0) {
	    caret -= c
	    text = string_delete(text, caret + 1, c)
	  }
	  c = l - n + 1
	  if (c > 0) {
	    text = string_insert(string_copy(t, n, c), text, caret + 1)
	    caret += c
	  }
	}
	keyboard_string = filltext
	caret = max(0, min(caret, string_length(text)))
	
	if keyboard_check_pressed(vk_enter) {
		log("$ " + text)
		eval(text)
		keyboard_string = ""
		text = ""
    caret = 0
	}
	if keyboard_check(vk_control) and keyboard_check_pressed(ord("C")) {
		log(text + "^C")
		keyboard_string = ""
	}	
	if keyboard_check_pressed(vk_up) {
		var prev_command = ds_list_find_value(console,ds_list_size(console)-2)
		prev_command = string_delete(prev_command, 1, 2)
		text = prev_command
		caret = string_length(text)
	}
	if keyboard_check_pressed(vk_down) {
		text = ""
	}
	return
}

if keyboard_check_pressed(vk_pageup) {
	if timescale < 5 {
		timescale += .5
		var ts = timescale
		with (Worker) {
			path_speed = base_path_speed * ts	
		}
		with (Bullet) {
			speed = base_bullet_speed * ts	
		}
	}
}

if keyboard_check_pressed(vk_pagedown) {
	if timescale > 0 {
		timescale -= .5
		var ts = timescale
		with (Worker) {
			path_speed = base_path_speed * ts
		}
		with (Bullet) {
			speed = base_bullet_speed * ts	
		}
	}
}

if keyboard_check_pressed(ord("1")) {
	timescale = 1;	
	
	var ts = timescale
	with (Worker) {
		path_speed = base_path_speed * ts
	}
	with (Bullet) {
		speed = base_bullet_speed * ts	
	}
}

if keyboard_check_pressed(ord("2")) {
	timescale = 2.5;
	
	var ts = timescale
	with (Worker) {
		path_speed = base_path_speed * ts
	}
	with (Bullet) {
		speed = base_bullet_speed * ts	
	}
}

if keyboard_check_pressed(ord("3")) {
	timescale = 5;
	
	var ts = timescale
	with (Worker) {
		path_speed = base_path_speed * ts
	}
	with (Bullet) {
		speed = base_bullet_speed * ts	
	}
}

if keyboard_check_pressed(vk_space) {
	if timescale != 0 {
		prev_timescale = timescale
		timescale = 0
	} else {
		timescale = prev_timescale
	}
	var ts = timescale
	with (Worker) {
		path_speed = base_path_speed * ts
	}
	with (Bullet) {
		speed = base_bullet_speed * ts	
	}
}
#endregion

if keyboard_check_pressed(vk_f5) {
	save_game()
}

if keyboard_check_pressed(vk_f6) {
	load_game()
}

if keyboard_check_pressed(ord("R")) {
	with (Person) {
		if selected {
			if ds_priority_find_max(tasks) != "DRAFT" {
				queue_add("DRAFT")
			} else {
				queue_pop()
			}
		}
	}
}