function get_object_work(argument0) {
	var object = argument0

	switch object {
		case Dummy:
			return 50
		case WoodWall:
			return 50
		case Lamp:
			return 50
		case Couch:
			return 100
		case Floor:
			return 20
		default:
			return 0
	}


}
