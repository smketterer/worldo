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
	default:
		return ""
}