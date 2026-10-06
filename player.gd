extends CharacterBody2D
class_name Player

var dir := Vector2.ZERO
@export var speed := 400
@export var rotation_speed := 10
@export var sprite: AnimatedSprite2D
@export var light: PointLight2D
@export var lantern: PointLight2D
@export var is_using_controller := false
@export var battery_time = 30
@export var camera : Camera2D

signal picked_up_item(item: Item)

var door_layer
var can_use_torch = true
var wants_to_use_torch = false
var inventory: Inventory

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
	
	if Input.is_action_just_pressed("Toggle_light"):
		wants_to_use_torch = not wants_to_use_torch
	
	can_use_torch = inventory.battery_percentage > 0
		
	light.visible = can_use_torch and wants_to_use_torch
		
	if light.visible:
		inventory.battery_percentage -= (delta/battery_time) * 100
		if inventory.battery_percentage < 0: inventory.battery_percentage = 0
		
	if Input.is_action_just_pressed("Interact"):
		if not inventory.current_item: return 
		inventory.current_item.use(self)
		inventory.current_item = null
		
	inventory.lantern_time_left -= delta 
	if inventory.lantern_time_left < 0: inventory.lantern_time_left = 0
		
	lantern.visible = inventory.lantern_time_left > 0
	
	move_and_slide()
	
func _on_pickup_area_area_entered(area: Area2D) -> void:
	if not area is Item: return 
	var item: Item = area
	
	if not item.requires_interact:
		item.use(self)
		return
	
	if inventory.current_item:
		return
	
	inventory.current_item = item
	picked_up_item.emit(item)
	
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("hit")
