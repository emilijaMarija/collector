extends CanvasLayer

class_name IntroScreen

signal end

const _intro_jingle: AudioStream = preload("res://sound/music/Intro.wav")

@onready var animation_player: AnimationPlayer = $AnimationPlayer

static var _intro_scene: PackedScene = preload("res://scenes/intro_screen.tscn")

static func create():
	var intro = _intro_scene.instantiate()
	return intro

enum ANIM {
	ZEROTH,
	FIRST,
	SECOND,
	THIRD,
	UNLOCK,
	LAST
}

var animation_names = {
	ANIM.ZEROTH: "any_btn",
	ANIM.FIRST: "intro_screen",
	ANIM.SECOND: "second_text",
	ANIM.THIRD: "third_text",
	ANIM.UNLOCK: "unlock_display",
	ANIM.LAST: "last_anim"
}

const _unlock_sound: AudioStream = preload("res://sound/music/ability_unlock.wav")

const _guitar_talk_sounds: Array[AudioStream] = [
	preload("res://sound/music/guitar_talk_1.wav"),
	preload("res://sound/music/guitar_talk_2.wav"),
	preload("res://sound/music/guitar_talk_3.wav")
]

const _volumes: Array[float] = [
	Volume.GUITAR_TALK_1,
	Volume.GUITAR_TALK_2,
	Volume.GUITAR_TALK_3,
]

func _play_jingle():
	OneShotSound.play(_intro_jingle, Volume.INTRO_JINGLE)

var _current_animation = 0

func _input(event: InputEvent) -> void:
	if _current_animation == 0 and event is InputEventMouseButton and event.pressed:
		_current_animation += 1
		call_deferred("_play_jingle")
		animation_player.play(animation_names[_current_animation])
	if (event is InputEventMouseButton or event is InputEventKey) and event.pressed:
		if not animation_player.current_animation == animation_names[_current_animation]:
			if not _current_animation == ANIM.LAST:
				_current_animation += 1
				animation_player.play(animation_names[_current_animation])


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation_names[ANIM.FIRST]:
		OneShotSound.play(_guitar_talk_sounds[0], Volume.GUITAR_TALK_1)
	elif anim_name == animation_names[ANIM.UNLOCK]:
		OneShotSound.play(_unlock_sound, Volume.UNLOCK_JINGLE)
	if anim_name == animation_names[ANIM.LAST]:
		end.emit()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == animation_names[ANIM.SECOND]:
		OneShotSound.play(_guitar_talk_sounds[1], Volume.GUITAR_TALK_2)
	elif anim_name == animation_names[ANIM.THIRD]:
		OneShotSound.play(_guitar_talk_sounds[2], Volume.GUITAR_TALK_3)
