extends CharacterBody2D

var dir := Vector2.ZERO
@export var speed := 400
@export var inventory := []
@export var torch_speed := 10


func _process(delta: float) -> void:
	dir = Input.get_vector("Left","Right","Up","Down").normalized()
		
	if dir != Vector2.ZERO:
		if dir.y < 0:
			$AnimatedSprite2D.play("Walking_up")
			#$PlayerCamera/Light.rotation = lerp($PlayerCamera/Light.rotation,deg_to_rad(0),.5)
			#if dir.x > 0:
				#$PlayerCamera/Light.rotation = lerp($PlayerCamera/Light.rotation,deg_to_rad(45),.5)
			#elif dir.x < 0:
				#$PlayerCamera/Light.rotation = lerp($PlayerCamera/Light.rotation,deg_to_rad(-45),.5)
		else:
			$AnimatedSprite2D.play("Walking")
	else:
		if $AnimatedSprite2D.animation == "Walking_up":
			$AnimatedSprite2D.play("Idle_up")
		elif $AnimatedSprite2D.animation != "Idle_up":
			$AnimatedSprite2D.play("Idle")
		
	$Light.rotation = lerp_angle($Light.rotation, get_angle_to(get_global_mouse_position()), delta*torch_speed)
	#if dir == Vector2.LEFT:
		#$PlayerCamera/Light.rotation = lerp($PlayerCamera/Light.rotation,deg_to_rad(270),.5)
	#elif dir == Vector2.RIGHT:
		#$PlayerCamera/Light.rotation = lerp($PlayerCamera/Light.rotation,deg_to_rad(90),.5)
	#elif dir.y > 0:
		#$PlayerCamera/Light.rotation = lerp($PlayerCamera/Light.rotation,deg_to_rad(180),.5)
		#if dir.x > 0:
			#$PlayerCamera/Light.rotation = lerp($PlayerCamera/Light.rotation,deg_to_rad(135),.5)
		#elif dir.x < 0:
			#$PlayerCamera/Light.rotation = lerp($PlayerCamera/Light.rotation,deg_to_rad(225),.5)
	
	velocity = dir * speed
	
	move_and_slide()

func rotation_lerp(from,to,weight):
	if from > to:
		lerp(from,deg_to_rad(rad_to_deg(to)*-1),weight)

func _on_pickup_area_area_entered(area: Area2D) -> void:
	inventory.append(area.get_parent().get_meta("Item"))
	print(inventory[0])
	area.get_parent().call_deferred("reparent",self)
	area.get_parent().global_position = global_position + Vector2(0,-10)
	area.get_parent().frame = 0
	area.get_parent().speed_scale = 2
	area.get_parent().collected = true
	area.get_parent().play("Spin")


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("hit")
