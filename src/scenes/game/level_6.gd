extends Level

var first_enter = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if first_enter and body == player:
		player.frozen = true
		first_enter = false
		var outro_scene = OutroScene.create()
		add_child(outro_scene)
		outro_scene.end.connect(func():
			remove_child(outro_scene)
			player.frozen = false
		)
