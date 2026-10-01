extends CharacterBody2D

var dir := Vector2.ZERO
@export var speed := 400
@export var inventory := []
@export var rotation_speed := 10
@export var sprite: AnimatedSprite2D
@export var light: PointLight2D
var door_layer


func _process(delta: float) -> void:
	dir = Input.get_vector("Left","Right","Up","Down").normalized()
		
	if dir != Vector2.ZERO:
		sprite.play("Walking")
	else:
		sprite.play("Idle")
		
	rotation = lerp_angle(rotation, (get_global_mouse_position() - global_position).angle(), delta*rotation_speed)
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
