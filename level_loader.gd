extends Node

@export var player_scene: PackedScene
@export var enemy_scene: PackedScene
@export var inventory: Inventory
@export var ui:CanvasLayer
@export var ui_label:Label
@export var throwable_scene : PackedScene
@export var light_percent : ProgressBar
@export var item : TextureRect
@export var coin : Label


var levels: Array[String]
var loaded_levels: Array[Node]
var current_player: Player
var current_level: Node
var current_level_number := -1
var title_screen_scene = preload("res://title_screen.tscn")
var title_screen



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title()

func title():
	title_screen = title_screen_scene.instantiate()
	call_deferred("add_child",title_screen)
	title_screen.connect("start",start)

func start() -> void:
	title_screen.call_deferred("queue_free")
	var dir = DirAccess.open("res://levels")
	if dir == null: printerr("Couldn't open levels folder"); return
	dir.list_dir_begin()
	for file: String in dir.get_files():
		levels.append(dir.get_current_dir() + "/" + file)
		
	load_level(true)
	
func _process(delta: float) -> void:
	light_percent.value = inventory.battery_percentage
	if inventory.current_item != null:
		item.texture = inventory.current_item.display_image
	else:
		item.texture = null
	
	coin.text = "Coin: " + str(inventory.number_of_coins)
	
		
func get_player_spawn_location(exit: bool):
	for child in current_level.get_children():
		if child is not PlayerSpawner: continue
		var player_spawner: PlayerSpawner = child
		if not exit == player_spawner.is_exit: continue
		return player_spawner.position
		
func spawn_enemies():
	for child in current_level.get_children():
		if child is not EnemySpawner: continue
		var enemy_spawner: EnemySpawner = child
		var new_enemy: Ghost = enemy_scene.instantiate()
		new_enemy.position = enemy_spawner.position
		new_enemy.player = current_player
		current_level.call_deferred("add_child",new_enemy)

func connect_level_triggers():
	for child in current_level.get_children():
		if child is not Door: continue
		var door: Door = child
		if not door.is_level_trigger: continue
		door.change_level.connect(load_level)
		
func level_teardown():
	disconnect_player_hit()
	current_player.picked_up_item.disconnect(remove_item)

	for child in current_level.get_children():
			if child is Player or child is Ghost:
				child.queue_free()
			
			if child is Door and child.is_level_trigger:
				var door: Door = child
				door.change_level.disconnect(load_level)
			
	call_deferred("remove_child",current_level)
	
func remove_item(item: Item):
	current_level.call_deferred("remove_child", item)
	
func restart_game():
	for level in loaded_levels:
		level.queue_free()
	loaded_levels = []
	current_level_number = -1
	current_player.inventory.reset()
	title()
	#load_level(true)
	
func connect_player_hit():
	current_player.player_hit.connect(restart_game)

func disconnect_player_hit():
	current_player.player_hit.disconnect(restart_game)

func load_level(is_going_up: bool):
	var level_number = current_level_number + (1 if is_going_up else - 1)
		
	if current_level:
		level_teardown()
	
	current_level_number = level_number 
	ui_label.text = "Room "+str(current_level_number+1)
	
	if current_level_number < loaded_levels.size():
		current_level = loaded_levels[current_level_number]
	else:
		var level_scene: PackedScene = load(levels[randi_range(0, levels.size() -1)])
		current_level = level_scene.instantiate()
		var canvas_modulate := CanvasModulate.new()
		canvas_modulate.color = Color.BLACK
		current_level.add_child(canvas_modulate)
		loaded_levels.append(current_level)
	
	call_deferred("add_child",current_level)
	
	var player: Player = player_scene.instantiate()
	
	player.position = get_player_spawn_location(not is_going_up)
	current_level.call_deferred("add_child",player)
	current_player = player
	current_player.picked_up_item.connect(remove_item)
	current_player.inventory = inventory
	current_player.connect("throw_glowstick",throw_glowstick)
	connect_player_hit()
	
	spawn_enemies()
	connect_level_triggers()

func throw_glowstick(pos,dir):
	var glowstick = throwable_scene.instantiate()
	current_level.call_deferred("add_child", glowstick)
	glowstick.dir = dir
	glowstick.global_position = pos
