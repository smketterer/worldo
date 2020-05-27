function get_object_requirement(argument0) {
	var object = argument0

	switch object {
		case Dummy:
			return Wood
		case WoodWall:
			return Wood
		case Lamp:
			return Stone
		case Couch:
			return Wood
		case Floor:
			return Wood
		default:
			return noone
	}


}
