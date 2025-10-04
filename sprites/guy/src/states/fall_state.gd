extends State

class_name PlayerFallState

func _ready():
	animated_sprite.play(PlayerAnimation.FALL)
	
func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis("move_left", "move_right") * PlayerConstants.GLIDE_SPEED * _delta
	if persistent_state.is_on_floor():
		if persistent_state.velocity.x == 0:
			change_state.call(StateFactory.STATE_IDLE)
		else:
			change_state.call(StateFactory.STATE_RUN)
	super._physics_process(_delta)
			
func _process(_delta):
	if Input.is_action_just_pressed("move_right"):
		animated_sprite.flip_h = false
	elif Input.is_action_just_pressed("move_left"):
		animated_sprite.flip_h = true
