/// @desc Get names from imported CSVs
/// @arg type File to import from.
function get_name(argument0) {
	var type = argument0

	file_grid = load_csv(type + ".csv");
	var h = ds_grid_height(file_grid);
	var index = floor(random(h))
	return file_grid[# 0, index]


}
