extends AnimatedSprite2D

class_name Door

signal change_level(is_going_up)

@export var is_level_trigger := false
@export var is_going_up := false
@export var key_required := false
@export var hitbox : CollisionShape2D
@export var area : Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Player: return 
	var player: Player = body 
	
	if key_required and player.inventory.key_count < 1:
		return 
		
	if key_required:
		player.inventory.key_count -= 1
		key_required = false
		
	if not(is_level_trigger and not is_going_up):
		frame = 1
		hitbox.set_deferred("disabled", true)
	
	if is_level_trigger:
		if not is_going_up: return
		change_level.emit(is_going_up)

		
