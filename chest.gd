extends AnimatedSprite2D

@export var hitbox : StaticBody2D
@export var area : Area2D
@export var item_scenes: Array[PackedScene]

var opened = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Player: return 
	if opened: return
	opened = true
	var player: Player = body 
	if player.inventory.current_item:
		player.inventory.number_of_coins += 1 
	else:
		var random_number = randi_range(0, item_scenes.size() - 1)
		player.inventory.current_item = item_scenes[random_number].instantiate()
	frame = 1
