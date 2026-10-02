extends Node

@export var player_scene: PackedScene
@export var enemy_scene: PackedScene

var levels: Array[String]
var loaded_levels: Array[Node]
var current_player: Player
var current_level: Node
var current_level_number := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dir = DirAccess.open("res://levels")
	if dir == null: printerr("Couldn't open levels folder"); return
	dir.list_dir_begin()
	for file: String in dir.get_files():
		levels.append(dir.get_current_dir() + "/" + file)
		
	load_level(current_level_number)
		
func get_player_spawn_location(exit: bool):
	for child in get_children():
		if child is not PlayerSpawner: continue
		var player_spawner: PlayerSpawner = child
		if not exit == player_spawner.is_exit: continue
		return player_spawner.position
		
func spawn_enemies():
	for child in get_children():
		if child is not EnemySpawner: continue
		var enemy_spawner: EnemySpawner = child
		var new_enemy: Ghost = enemy_scene.instantiate()
		new_enemy.position = enemy_spawner.position
		new_enemy.player = current_player
		current_level.add_child(new_enemy)

func connect_level_triggers():
	for child in get_children():
		if child is not LevelTrigger: continue
		var level_trigger: LevelTrigger = child
		level_trigger.change_level.connect(load_level(current_level_number + 1 if level_trigger.is_going_up else -1))

func load_level(level_number: int):
	for loaded_level: Node in get_children():
		remove_child(loaded_level)
	
	var previous_level_number := current_level_number
	current_level_number = level_number 
	
	
	if current_level_number < loaded_levels.size():
		current_level = loaded_levels[current_level_number]
		add_child(current_level)
	else:
		var level_scene: PackedScene = load(levels[randi_range(0, levels.size() -1)])
		current_level = level_scene.instantiate()
		loaded_levels.append(current_level)
	
	add_child(current_level)
	
	var player: Player = player_scene.instantiate()
	player.position = get_player_spawn_location(previous_level_number > current_level_number)
	current_level.add_child(player)
	current_player = player
	
	spawn_enemies()
	
		
	
	
	
