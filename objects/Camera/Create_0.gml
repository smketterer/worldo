zoom_level = 1
default_zoom_width = camera_get_view_width(view_camera[0])
default_zoom_height = camera_get_view_height(view_camera[0])
cursor_x = 0
cursor_y = 0

camera_set_view_pos(view_camera[0], (room_width / 2) - (default_zoom_width / 2), (room_height / 2) - (default_zoom_height / 2))
surface_resize(application_surface, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));