extends CharacterBody2D

var player
@export var speed := 80

func _process(delta: float) -> void:
	var angle_to_self = player.get_angle_to(self.global_position)
	var angle_to_mouse = player.get_angle_to(get_global_mouse_position())
	#if player.
	velocity = Vector2.from_angle(get_angle_to(player.global_position)).normalized() * speed
	
	
	move_and_slide()

func enemy():
	pass
