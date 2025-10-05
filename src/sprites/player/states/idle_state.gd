extends State

class_name IdleState

func _ready():
	animated_sprite.play(PlayerAnimation.IDLE)

func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h

func _process(_delta):
	if persistent_state.frozen:
		persistent_state.velocity.x = 0
		return
	if not persistent_state.is_on_floor():
		change_state.call(StateFactory.STATE_FALL)
	if Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) != 0:
		change_state.call(StateFactory.STATE_WALK)
	elif persistent_state.can_jump() and Input.is_action_pressed(GameInput.JUMP):
		change_state.call(StateFactory.STATE_JUMP_KNEEL)
	elif persistent_state.can_dash() and persistent_state.is_attempting_dash():
		change_state.call(StateFactory.STATE_DASH)
