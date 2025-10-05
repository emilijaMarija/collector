extends State

class_name SprintState

func _ready():
	animated_sprite.play(PlayerAnimation.SPRINT)

func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) * PlayerConstants.SPRINT_SPEED * _delta
	super._physics_process(_delta)
	
func _process(_delta):
	if not Input.is_action_pressed(GameInput.WALK_LEFT) and not Input.is_action_pressed(GameInput.WALK_RIGHT):
		change_state.call(StateFactory.STATE_IDLE)
		return
	if not Input.is_action_pressed(GameInput.SPRINT):
		change_state.call(StateFactory.STATE_WALK)
		return
	
	persistent_state.stamina -= PlayerConstants.STAMINA_DEPLETE_RATE * _delta
	if persistent_state.stamina <= 0:
		persistent_state.stamina = 0
		change_state.call(StateFactory.STATE_WALK)
		return
	
	if Input.is_action_pressed(GameInput.WALK_RIGHT):
		animated_sprite.flip_h = false
	elif Input.is_action_pressed(GameInput.WALK_LEFT):
		animated_sprite.flip_h = true
		
	if Input.is_action_pressed(GameInput.JUMP):
		change_state.call(StateFactory.STATE_JUMP_KNEEL)
	elif persistent_state.can_dash() and persistent_state.is_attempting_dash():
		change_state.call(StateFactory.STATE_DASH)
