event_inherited()

// Child objects set this
polygon = polygon_from_instance(id);
shadow_length = sprite_height * 4;

// Default shadow caster flags
flags = eShadowCasterFlags.None;

// The maximum length of shadows cast by this shadow caster
// shadow_length -- this is an object variable

//
// Internal
//

// The cached polygon is automatically maintained by the system to optimize static shadow casters
cached_polygon_area = undefined;

// Is the shadow caster outside the active camera?
outside_active_camera = false;
// The last camera this shadow caster was compared against,
// as the view array
last_camera = undefined;