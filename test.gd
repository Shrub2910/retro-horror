extends Node2D

@export var player_scene : PackedScene
@export var ghoist_scene : PackedScene
var player
var ghoist

func _ready() -> void:
	player = player_scene.instantiate()
	add_child(player)
	player.global_position = Vector2(0, 0)
	ghoist = ghoist_scene.instantiate()
	add_child(ghoist)
	ghoist.global_position = Vector2(0, 0)
	ghoist.player = player
