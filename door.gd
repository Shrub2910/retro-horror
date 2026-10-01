extends AnimatedSprite2D

@export var hitbox : StaticBody2D
@export var area : Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	frame = 1
	area.set_deferred("monitoring",false)
	hitbox.queue_free()
