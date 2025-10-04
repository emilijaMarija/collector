extends State

class_name PlayerJumpState

func _finished():
	change_state.call(StateFactory.STATE_FALL)

func _ready():
	animated_sprite.animation_finished.connect(_finished)
	animated_sprite.play(PlayerAnimation.JUMP)
	persistent_state.velocity.y = -1.0 * PlayerConstants.JUMP_VELOCITY
	
func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis("move_left", "move_right") * PlayerConstants.GLIDE_SPEED * _delta
	super._physics_process(_delta)

func _process(_delta):
	if Input.is_action_just_pressed("move_right"):
		animated_sprite.flip_h = false
	elif Input.is_action_just_pressed("move_left"):
		animated_sprite.flip_h = true
