extends Area2D
class_name Item

@export var item_name: String = ""
@export var requires_interact: bool

func use(player: Player):
	queue_free()
