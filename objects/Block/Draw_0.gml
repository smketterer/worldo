draw_sprite_ext(shadow0, image_index, x+sprite_width/2, y+(sprite_height-8), image_xscale, image_yscale, image_angle, image_blend, abs(sqr(Manager.current_darkness)-1))

image_alpha = 1 - (claimed * .5)
draw_self()
image_alpha = 1