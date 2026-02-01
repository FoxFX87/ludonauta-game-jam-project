extends Node2D
class_name Rooms

enum Type { BOTTOM, MIDDLE, TOP }

@export var sample_tile_layer: TileMapLayer

var room_size : Vector2i = Vector2i.ZERO
var cell_size : Vector2i = Vector2i.ZERO

var _rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_SCENE_INSTANTIATED:
		_rng.randomize()
		var room: TileMapLayer = sample_tile_layer
		room_size = room.get_used_rect().size
		cell_size = room.tile_set.tile_size

func get_room_data(type: int) -> Dictionary[String, Array]:
	var group: Node2D = get_child(type)
	var index: int = _rng.randi_range(0, group.get_child_count() - 1)
	var room: TileMapLayer = group.get_child(index)
	var data: Dictionary[String, Array] = {"objects": [], "tilemap": []}
	
	for object: Node2D in room.get_children():
		data.objects.push_back(object)
	
	for v in room.get_used_cells():
		data.tilemap.push_back(
			{
				"offset": v, 
				#"cell": room.get_cell_tile_data(v), 
				"atlas": room.get_cell_atlas_coords(v), 
				"source_id": room.get_cell_source_id(v),
				"alternative": room.get_cell_alternative_tile(v),
				}
		)
	
	return data
