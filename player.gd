extends CharacterBody2D

var dir := Vector2.ZERO
var speed := 400

func _process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		dir = Vector2.LEFT
	elif Input.is_action_pressed("Right"):
		dir = Vector2.RIGHT
	elif Input.is_action_pressed("Up"):
		dir = Vector2.UP
	elif Input.is_action_pressed("Down"):
		dir = Vector2.DOWN
	else:
		dir = Vector2.ZERO
		
	if dir != Vector2.ZERO:
		if dir == Vector2.UP:
			$AnimatedSprite2D.play("Walking_up")
		else:
			$AnimatedSprite2D.play("Walking")
	else:
		$AnimatedSprite2D.play("Idle")
	
	velocity = dir * speed
	
	move_and_slide()
