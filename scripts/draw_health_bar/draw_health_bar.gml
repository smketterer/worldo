var top = argument0

draw_set_colour(c_maroon)
draw_rectangle(8,top+34,8+round(60*(inspecting.hp/inspecting.max_hp)),top+44,false)
draw_set_colour(c_black)
draw_rectangle(9,top+35,8+59,top+44,true)
draw_set_halign(fa_center)
draw_text(8+30,top+33,string(round(inspecting.hp)) + "/" + string(inspecting.max_hp))
draw_set_colour(c_white)
draw_rectangle(8,top+34,8+60,top+44,true)
draw_text(8+30,top+32,string(round(inspecting.hp)) + "/" + string(inspecting.max_hp))
draw_set_halign(fa_left)