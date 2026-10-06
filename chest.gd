extends AnimatedSprite2D

@export var hitbox : StaticBody2D
@export var area : Area2D
@export var lantern_scene: PackedScene
@export var glow_stick_scene: PackedScene

var opened = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Player: return 
	if opened: return
	opened = true
	var player: Player = body 
	if player.inventory.current_item:
		player.inventory.number_of_coins += 1 
	else:
		var random_number = randi_range(1,2)
		player.inventory.current_item = (lantern_scene if random_number == 1 else glow_stick_scene).instantiate()
	frame = 1
