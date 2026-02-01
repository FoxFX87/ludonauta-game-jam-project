class_name HurtArea2D
extends Area2D

signal hurt(damage: int)

func _ready() -> void:
	area_entered.connect(
		func _on_hurt_area_entered(hit_area: HitArea2D) -> void:
			hurt.emit(hit_area.damage)
	)
