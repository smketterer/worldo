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
++tick;
#endregion

#region Time scaling
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

if keyboard_check_pressed(vk_escape) {
	game_end();
}

if keyboard_check_pressed(ord("R")) {
	with (Person) {
		if selected {
			if ds_priority_find_max(tasks) != "WAR" {
				queue_add("WAR")
			} else {
				queue_pop()
			}
		}
	}
}