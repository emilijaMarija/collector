extends State

class_name WalkState

func _ready():
	animated_sprite.play(PlayerAnimation.WALK)

func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) * PlayerConstants.WALK_SPEED * _delta

	super._physics_process(_delta)
	
func _process(_delta):
	if Input.is_action_pressed(GameInput.WALK_RIGHT):
		animated_sprite.flip_h = false
	elif Input.is_action_pressed(GameInput.WALK_LEFT):
		animated_sprite.flip_h = true
	
	if Input.is_action_pressed(GameInput.JUMP):
		change_state.call(StateFactory.STATE_JUMP_KNEEL)
	elif Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) == 0:
		persistent_state.velocity.x = 0
		change_state.call(StateFactory.STATE_IDLE)
	elif Input.is_action_just_pressed(GameInput.SPRINT) and persistent_state.stamina >= PlayerConstants.MIN_SPRINT_STAMINA_THRESHOLD:
		change_state.call(StateFactory.STATE_SPRINT)
	elif persistent_state.can_dash() and persistent_state.is_attempting_dash():
		change_state.call(StateFactory.STATE_DASH)
