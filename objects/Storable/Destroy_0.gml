// need to deactivate zone

if place_meeting(x,y,Zone) {
		var zone = instance_place(x,y,Zone)
		zone.claimed = false
		zone.claimed_by = noone
}