extends State

class_name RunState

func _ready():
	animated_sprite.play(PlayerAnimation.WALK)

func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis("move_left", "move_right") * PlayerConstants.WALK_SPEED * _delta
	
	super._physics_process(_delta)
	
func _process(_delta):
	if Input.is_action_pressed("move_right"):
		animated_sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		animated_sprite.flip_h = true
		
	if Input.is_action_pressed("jump"):
		change_state.call(StateFactory.STATE_JUMP)
	if Input.get_axis("move_left", "move_right") == 0:
		persistent_state.velocity.x = 0
		change_state.call(StateFactory.STATE_IDLE)
