extends State

class_name PlayerFallState

func _ready():
	animated_sprite.play(PlayerAnimation.FALL)
	
func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) * PlayerConstants.GLIDE_SPEED * _delta
	
	if Input.is_action_just_pressed(GameInput.WALK_RIGHT):
		animated_sprite.flip_h = false
	elif Input.is_action_just_pressed(GameInput.WALK_LEFT):
		animated_sprite.flip_h = true
	
	if persistent_state.num_jumps == 1 and persistent_state.ability_registry.has_ability(AbilityRegistry.Ability.DOUBLE_JUMP) and Input.is_action_just_pressed(GameInput.JUMP):
		change_state.call(StateFactory.STATE_JUMP_KNEEL)
		return
	
	if persistent_state.is_on_floor():
		persistent_state.num_jumps = 0
		if Input.is_action_just_pressed(GameInput.WALK_RIGHT) or Input.is_action_just_pressed(GameInput.WALK_LEFT):
			change_state.call(StateFactory.STATE_WALK)
		else:
			change_state.call(StateFactory.STATE_IDLE)
	super._physics_process(_delta)
