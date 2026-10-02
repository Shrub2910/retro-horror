extends AnimatedSprite2D

class_name  LevelTrigger

signal change_level(direction)

@export var is_going_up : bool
@export var hitbox : StaticBody2D
@export var area : Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.basic_key_count >= 1:
		body.basic_key_count -= 1
		frame = 1
		area.set_deferred("monitoring",false)
		hitbox.queue_free()
		change_level.emit(is_going_up)
