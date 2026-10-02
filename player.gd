extends CharacterBody2D
class_name Player

var dir := Vector2.ZERO
@export var speed := 400
@export var inventory := []
@export var rotation_speed := 10
@export var sprite: AnimatedSprite2D
@export var light: PointLight2D
@export var basic_key_count := 0
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
