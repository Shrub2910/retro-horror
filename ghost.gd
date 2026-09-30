extends CharacterBody2D

var player: CharacterBody2D
@export var speed := 80


func _process(delta: float) -> void:
	var angle_to_self = player.get_angle_to(self.global_position)
	var angle_to_mouse = player.get_angle_to(get_global_mouse_position())
	
	var player_look_direction = (get_global_mouse_position() - player.position).normalized()
	
	if not (player_look_direction.dot((position - player.position).normalized()) > 0.9 and (position - player.position).length() < 100):
		velocity = Vector2.from_angle(get_angle_to(player.global_position)).normalized() * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func enemy():
	pass
