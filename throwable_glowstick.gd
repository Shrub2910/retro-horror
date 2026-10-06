extends CharacterBody2D

var speed := 80
var dir := Vector2.RIGHT
@export var sprite : Sprite2D
var slow := false
var rotation_speed = 2*PI

func _ready() -> void:
	velocity = dir * speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func _process(delta: float) -> void:
	sprite.rotate(rotation_speed*delta)
	rotation_speed = lerp(rotation_speed,0.0,delta*2)
	if slow: velocity = lerp(velocity,Vector2.ZERO,delta*2)


func _on_timer_timeout() -> void:
	slow = true
