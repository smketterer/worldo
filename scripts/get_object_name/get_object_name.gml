function get_object_name(argument0) {
	var object = argument0

	switch object {
		case Dummy:
			return "training dummy"
		case WoodWall:
			return "wooden wall"
		case Lamp:
			return "standing lamp"
		case Couch:
			return "leather couch"
		case Floor:
			return "floor"
		default:
			return ""
	}


}
