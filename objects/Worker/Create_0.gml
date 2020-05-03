event_inherited()

// properties base
hp = 50
max_hp = 50
move_speed = round(random(10))

// skills base
chopping_skill = 2 + round(random(5))
cutting_skill = 2 + round(random(5))
constructing_skill = 2 + round(random(5))
hauling_skill = 2 + round(random(5))
shooting_skill = 2 + round(random(5))
building_skill = 2 + round(random(5))

// needs base
hungry = 100
tired = 100
isolated = 100

// movable (worker) base
path = path_add()
base_path_speed = 1 + (move_speed / 8)

// ai base
tasks = ds_priority_create()
hauling = noone
hauling_to = undefined

// combat base
aiming = false
target = noone
attack_cooldown = 30
attack_counter = attack_cooldown