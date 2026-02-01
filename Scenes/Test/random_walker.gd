extends Node2D
class_name RandomWalker

signal _path_completed()

@export var rooms_scene: PackedScene
@export var instructions: PackedScene
@export var height: int = 10
@export_range(0, 1.0) var basic_enemy_spawn_chance: float = 0.5

@onready var level: TileMapLayer = $TestGen
@onready var timer: Timer = $Timer

var _rooms: Rooms = null
var _rng : RandomNumberGenerator = RandomNumberGenerator.new()
var _current_room_count: int = 0
var _state: Dictionary = {}

func _ready() -> void:
	if not Global.instructed:
		var inst = instructions.instantiate()
		get_parent().add_child.call_deferred(inst)
	height += Global.level * 5
	_rng.randomize()
	_rooms = rooms_scene.instantiate()
	_generate_level()

func _generate_level() -> void:
	_update_start_position()
	
	while  _current_room_count < height:
		_update_middle()
	_update_end()

func _update_start_position() -> void:
	_state.offset = Vector2i(0, 0)
	_copy_room_data(_state.offset, Rooms.Type.BOTTOM)
	_jump_up_to_next_section()

func _update_middle() -> void:
	_copy_room_data(Vector2i(0, -_current_room_count), Rooms.Type.MIDDLE)
	_jump_up_to_next_section()
	pass

func _update_end() -> void:
	_copy_room_data(Vector2i(0, -_current_room_count), Rooms.Type.TOP)
	_path_completed.emit()

func _jump_up_to_next_section() -> void:
	_current_room_count += 1

func _copy_room_data(offset: Vector2i, type: int):
	var world_offset = _grid_to_world(offset)
	var map_offset = _grid_to_map(offset)
	var data = _rooms.get_room_data(type)
	
	for o: Node2D in data.objects:
		
		if o is OneTimeArea or o is EndDoor:
			var new_object: Node2D = o.duplicate()
			new_object.global_position += world_offset
			get_tree().get_first_node_in_group("EventGroup").add_child(new_object)
		
		elif o.is_in_group("Enemy") and _rng.randf() < basic_enemy_spawn_chance:
			var new_object: Node2D = o.duplicate()
			new_object.position += world_offset
			get_tree().get_first_node_in_group("EnemyParent").add_child(new_object)
	
	for d in data.tilemap:
		var new_offset: Vector2i = d.offset
		var new_source_id: int = d.source_id
		var atlas: Vector2i = d.atlas
		var alternative: int = d.alternative
		level.set_cell(map_offset + new_offset, new_source_id, atlas, alternative)
	

func _grid_to_map(vector: Vector2i) -> Vector2i: 
	return _rooms.room_size * vector

func _grid_to_world(vector: Vector2i) -> Vector2:
	return _rooms.cell_size * _rooms.room_size * vector
