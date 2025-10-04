extends State

class_name PlayerJumpKneelState


func _anim_finished():
	change_state.call(StateFactory.STATE_JUMP)

func _ready():
	animated_sprite.animation_finished.connect(_anim_finished)
	animated_sprite.play(PlayerAnimation.JUMP_KNEEL)
	
func _physics_process(_delta):
	if Input.is_action_just_pressed(GameInput.WALK_RIGHT):
		animated_sprite.flip_h = false
	elif Input.is_action_just_pressed(GameInput.WALK_LEFT):
		animated_sprite.flip_h = true
	super._physics_process(_delta)

func _process(_delta):
	pass
