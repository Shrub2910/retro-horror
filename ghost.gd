extends CharacterBody2D
class_name Ghost

var player: Player
@export var speed := 80
@export var stun_time := 3
@export var look_angle := 0.95
@export var flash: PointLight2D

var stun_timer = 0

func stun():
	if player.transform.x.dot((position - player.position).normalized()) > look_angle:
		stun_timer = stun_time

func _ready() -> void:
	player.flashed.connect(stun)

func _process(delta: float) -> void:
	if not player.transform.x.dot((position - player.position).normalized()) > look_angle or !player.light.visible:
		velocity = Vector2.from_angle(get_angle_to(player.global_position)).normalized() * speed
	else:
		velocity = Vector2.ZERO
		
	stun_timer -= delta
	if stun_timer < 0: stun_timer = 0
	
	if stun_timer > 0:
		velocity = Vector2.ZERO
		flash.visible = true 
	else:
		flash.visible = false
	
	move_and_slide()

func enemy():
	pass
