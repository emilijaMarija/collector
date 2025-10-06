extends State

class_name PlayerDieState

const _sound_death = preload("res://sound/fx/death.wav")

func _ready():
	animated_sprite.play(PlayerAnimation.DIE)
	persistent_state.velocity.x = 0
	OneShotSound.play(_sound_death, Volume.DEATH)
