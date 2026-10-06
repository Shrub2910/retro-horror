extends AnimatedSprite2D

@export var hitbox : StaticBody2D
@export var area : Area2D
@onready var coin_scene = preload("res://lantern.tscn")

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#frame = 1
	#area.set_deferred("monitoring",false)
	#var coin = coin_scene.instantiate()
	#get_tree().root.call_deferred("add_child",coin)
	#coin.global_position = global_position + Vector2(0,-8)
