extends AnimatedSprite2D

var collected := false

func _process(delta: float) -> void:
	pass
		


func _on_frame_changed() -> void:
	if collected:
		if frame == 12:
			queue_free()
		#scale = lerp(scale,Vector2(0.1,0.1),0.2)
		if frame < 6:
			offset.y -= 2
		elif frame > 6:
			offset.y += 2


func _on_animation_finished() -> void:
	if collected:
		queue_free()
