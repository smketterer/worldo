event_inherited()

if work <= 0 {
	// Check if it's a floor
	if object == Floor {
		var newinst = instance_create_layer(x,y,"Floors",object)
	} else {
		var newinst = instance_create_layer(x,y,"Instances",object)
	}
	instance_destroy()
}