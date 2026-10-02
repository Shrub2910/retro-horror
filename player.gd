extends CharacterBody2D

var dir := Vector2.ZERO
@export var speed := 400
@export var inventory := []
@export var rotation_speed := 10
@export var sprite: AnimatedSprite2D
@export var light: PointLight2D
@export var basic_key_count := 0
@export var is_using_controller := false
var door_layer


func _process(delta: float) -> void:
	dir = Input.get_vector("Left","Right","Up","Down").normalized()
		
	if dir != Vector2.ZERO:
		sprite.play("Walking")
	else:
		sprite.play("Idle")
		
	if is_using_controller:
		var look_angle = Vector2(snapped(Input.get_joy_axis(0,JOY_AXIS_RIGHT_X),0.01),snapped(Input.get_joy_axis(0,JOY_AXIS_RIGHT_Y),0.01)).normalized()
		if look_angle != Vector2.ZERO:
			rotation = lerp_angle(rotation, look_angle.angle(), delta*rotation_speed)
		else:
			pass
	else:
		rotation = lerp_angle(rotation, (get_global_mouse_position() - global_position).angle(), delta*rotation_speed)
	velocity = dir * speed
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Toggle_light"):
		if light.visible:
			light.hide()
		else:
			light.show()

func _on_pickup_area_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	var item = object.get_meta("Item")
	if item == "Basic key":
		basic_key_count += 1
	else:
		inventory.append(item)
		print(inventory[len(inventory)-1])
	if item == "Coin":
		object.call_deferred("reparent",self)
		object.global_position = global_position + Vector2(0,-10)
		object.frame = 0
		object.speed_scale = 2
		object.collected = true
		object.play("Spin")
	else:
		object.queue_free()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("hit")
