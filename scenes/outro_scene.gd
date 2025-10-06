extends Node2D

class_name OutroScene

signal end

static var _outro_scene: PackedScene = preload("res://scenes/outro_scene.tscn")

const _violin_talk: Array[AudioStream] = [
	preload("res://sound/music/violin_talk_1.wav"),
	preload("res://sound/music/violin_talk_2.wav"),
	preload("res://sound/music/violin_talk_3.wav")
]

static func create():
	var outro = _outro_scene.instantiate()
	return outro

@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum ANIM {
	FIRST,
	SECOND,
	THIRD,
	LAST
}

var animation_names = {
	ANIM.FIRST: "first_text",
	ANIM.SECOND: "second text",
	ANIM.THIRD: "third_text",
	ANIM.LAST: "end"
}

var _current_animation = 0

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton or event is InputEventKey) and event.pressed:
		if not animation_player.current_animation == animation_names[_current_animation]:
			if not _current_animation == ANIM.LAST:
				_current_animation += 1
				animation_player.play(animation_names[_current_animation])


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_names[ANIM.FIRST]:
		OneShotSound.play(_violin_talk[0], Volume.VIOLIN_TALK_1)
	elif anim_name == animation_names[ANIM.SECOND]:
		OneShotSound.play(_violin_talk[1], Volume.VIOLIN_TALK_2)
	elif anim_name == animation_names[ANIM.THIRD]:
		OneShotSound.play(_violin_talk[2], Volume.VIOLIN_TALK_3)
	if anim_name == animation_names[ANIM.LAST]:
		end.emit()
