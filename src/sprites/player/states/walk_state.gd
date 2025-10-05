extends State

class_name WalkState

const _walk_streams = [
	preload("res://sound/fx/walk/walk-1.wav"),
	preload("res://sound/fx/walk/walk-2.wav"),
	preload("res://sound/fx/walk/walk-3.wav"),
	preload("res://sound/fx/walk/walk-4.wav"),
]

var _step_timer: Timer

func _exit(next: int):
	change_state.call(next)

func _step():
	OneShotSound.play(_walk_streams.pick_random(), Volume.STEPS)

func _ready():
	_step_timer = Timer.new()
	_step_timer.autostart = true
	_step_timer.one_shot = false
	_step_timer.wait_time = 1.0 / 400.0 * 60.0
	_step_timer.timeout.connect(_step)
	add_child(_step_timer)
	_step()
	
	animated_sprite.play(PlayerAnimation.WALK)

func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) * PlayerConstants.WALK_SPEED * _delta
	super._physics_process(_delta)
	
func _process(_delta):
	if persistent_state.frozen:
		persistent_state.velocity.x = 0.0
		_exit(StateFactory.STATE_IDLE)
		return
	
	if Input.is_action_pressed(GameInput.WALK_RIGHT):
		animated_sprite.flip_h = false
	elif Input.is_action_pressed(GameInput.WALK_LEFT):
		animated_sprite.flip_h = true
	
	if Input.is_action_pressed(GameInput.JUMP):
		_exit(StateFactory.STATE_JUMP_KNEEL)
	elif Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) == 0:
		persistent_state.velocity.x = 0
		_exit(StateFactory.STATE_IDLE)
	elif Input.is_action_just_pressed(GameInput.SPRINT) and persistent_state.stamina >= PlayerConstants.MIN_SPRINT_STAMINA_THRESHOLD:
		_exit(StateFactory.STATE_SPRINT)
	elif persistent_state.can_dash() and persistent_state.is_attempting_dash():
		_exit(StateFactory.STATE_DASH)
