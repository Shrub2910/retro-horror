extends Area2D
class_name Item

@export var item_name: String = ""
@export var requires_interact: bool
@export var display_image: CompressedTexture2D

func use(player: Player):
	queue_free()
