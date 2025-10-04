extends State

class_name PlayerLandState

func _anim_end():
	if Input.is_action_just_pressed(GameInput.WALK_RIGHT) or Input.is_action_just_pressed(GameInput.WALK_LEFT):
		change_state.call(StateFactory.STATE_WALK)
	else:
		change_state.call(StateFactory.STATE_IDLE)

func _ready():
	animated_sprite.animation_finished.connect(_anim_end)
	animated_sprite.play(PlayerAnimation.LAND)
	persistent_state.velocity = Vector2(0.0, 0.0)
