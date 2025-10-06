extends CanvasLayer

class_name IntroScreen

signal end

@onready var animation_player: AnimationPlayer = $AnimationPlayer

static var _intro_scene: PackedScene = preload("res://scenes/intro_screen.tscn")

static func create():
	var intro = _intro_scene.instantiate()
	return intro

enum ANIM {
	FIRST,
	SECOND,
	THIRD,
	UNLOCK,
	LAST
}

var animation_names = {
	ANIM.FIRST: "intro_screen",
	ANIM.SECOND: "second_text",
	ANIM.THIRD: "third_text",
	ANIM.UNLOCK: "unlock_display",
	ANIM.LAST: "last_anim"
}

var _current_animation = 0

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventKey) and event.pressed:
		if not animation_player.current_animation == animation_names[_current_animation]:
			if not _current_animation == ANIM.LAST:
				_current_animation += 1
				animation_player.play(animation_names[_current_animation])


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_names[ANIM.LAST]:
		end.emit()
