extends ComponentClass
class_name AIWallFloorComponent

signal switch_left()
signal switch_right()

@export var left_wall_ray: RayCast2D
@export var right_wall_ray: RayCast2D
@export var left_floor_ray: RayCast2D
@export var right_floor_ray: RayCast2D

func update(_delta: float) -> void:
	if is_instance_valid(left_wall_ray) and left_wall_ray.is_colliding():
		switch_right.emit()
	if is_instance_valid(right_wall_ray) and right_wall_ray.is_colliding():
		switch_left.emit()
	if is_instance_valid(left_floor_ray) and not left_floor_ray.is_colliding():
		switch_right.emit()
	if is_instance_valid(right_floor_ray) and not right_floor_ray.is_colliding():
		switch_left.emit()
