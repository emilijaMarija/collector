extends State

class_name PlayerJumpState

func _ready():
	persistent_state.num_jumps+=1
	animated_sprite.play(PlayerAnimation.JUMP)
	
	var velocity = PlayerConstants.JUMP_VELOCITY
	if persistent_state.ability_registry.has_ability(AbilityRegistry.Ability.HIGHER_JUMP):
		velocity = PlayerConstants.HIGH_JUMP_VELOCITY
	
	persistent_state.velocity.y = -1.0 * velocity
	
func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) * PlayerConstants.GLIDE_SPEED * _delta
	if persistent_state.velocity.y >= 0:
		change_state.call(StateFactory.STATE_FALL)
		return
		
	if persistent_state.num_jumps == 1 and persistent_state.ability_registry.has_ability(AbilityRegistry.Ability.DOUBLE_JUMP) and Input.is_action_just_pressed(GameInput.JUMP):
		change_state.call(StateFactory.STATE_JUMP_KNEEL)
		return
	super._physics_process(_delta)

func _process(_delta):
	if Input.is_action_just_pressed(GameInput.WALK_RIGHT):
		animated_sprite.flip_h = false
	elif Input.is_action_just_pressed(GameInput.WALK_LEFT):
		animated_sprite.flip_h = true
	
	if persistent_state.can_dash() and persistent_state.is_attempting_dash():
		change_state.call(StateFactory.STATE_DASH)
