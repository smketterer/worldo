event_inherited()

// properties base
hp = 50
max_hp = 50
move_speed = random(10)

// skills base
chopping_skill = 5
cutting_skill = 5

// needs base
satiety = 100

// movable base
movable = true
path = path_add()
base_path_speed = 1 + (move_speed / 8)

// ai base
tasks = ds_priority_create()