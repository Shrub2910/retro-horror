extends Node2D

@export var player_scene : PackedScene
@export var ghoist_scene : PackedScene
var player
var ghoist

func _ready() -> void:
	player = player_scene.instantiate()
	add_child(player)
	player.global_position = Vector2(1465,1691)
	ghoist = ghoist_scene.instantiate()
	add_child(ghoist)
	ghoist.global_position = Vector2(1470,1601)
	ghoist.player = player
