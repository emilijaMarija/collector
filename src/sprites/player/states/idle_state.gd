extends State

class_name IdleState

func _ready():
	animated_sprite.play(PlayerAnimation.IDLE)

func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h

func _process(_delta):
	if Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) != 0:
		change_state.call(StateFactory.STATE_WALK)
	elif (Input.is_action_pressed(GameInput.JUMP)):
		change_state.call(StateFactory.STATE_JUMP_KNEEL)
