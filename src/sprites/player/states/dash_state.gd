extends State

class_name PlayerDashState

const _dash_sounds = [
	preload("res://sound/fx/dash/dash-1.wav"),
	preload("res://sound/fx/dash/dash-2.wav"),
	preload("res://sound/fx/dash/dash-3.wav"),
]

func _timeout():
	persistent_state.velocity.x = 0
	if persistent_state.is_on_floor():
		if Input.is_action_pressed(GameInput.WALK_RIGHT) or Input.is_action_pressed(GameInput.WALK_LEFT):
			persistent_state.change_state.call(StateFactory.STATE_WALK)
		else:
			persistent_state.change_state.call(StateFactory.STATE_IDLE)
	else:
		persistent_state.change_state.call(StateFactory.STATE_FALL)
		


func _ready():
	OneShotSound.play(_dash_sounds.pick_random(), Volume.DASH)
	persistent_state.last_dash = Time.get_unix_time_from_system()
	persistent_state.velocity.y = 0
	animated_sprite.play(PlayerAnimation.DASH)
	
	var timer = get_tree().create_timer(PlayerConstants.DASH_DURATION_SECONDS)
	timer.timeout.connect(_timeout)
	
	
func _physics_process(_delta):
	var side = -1.0 if animated_sprite.flip_h else 1.0
	persistent_state.velocity.x = side * PlayerConstants.DASH_SPEED * _delta
	super._physics_process(_delta)

func _process(_delta):
	pass
