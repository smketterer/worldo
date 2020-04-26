event_inherited()

// b g r a
var color = choose($FF0000FF, $FF00FF00, $FFFFFF00, $FFFFFFFF) // , $FFFFFFFF

light = instance_create_layer(x+8,y+8,layer,Light)
light.Light_Intensity = 1.75
light.Light_Range = 256
light.Light_Shadow_Length = 256
light.Light_Color = color
light.should_initialize = true

light_add = instance_create_layer(x+8,y+3,layer_get_id("Overlays"),LightAdd)
light_add.color = color