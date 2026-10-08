extends Node2D

signal start()

@export var high_score : Label
@export var last_score : Label

func _on_button_pressed() -> void:
	start.emit()
