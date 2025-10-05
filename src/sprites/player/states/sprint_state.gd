extends State

class_name SprintState

const _c_streams = [
	preload("res://sound/fx/sprint/sprint-c-1.wav"),
	preload("res://sound/fx/sprint/sprint-c-2.wav"),
	preload("res://sound/fx/sprint/sprint-c-4.wav"),
]

const _e_streams = [
	preload("res://sound/fx/sprint/sprint-e-1.wav"),
	preload("res://sound/fx/sprint/sprint-e-2.wav"),
	preload("res://sound/fx/sprint/sprint-e-3.wav"),
	preload("res://sound/fx/sprint/sprint-e-4.wav"),
]

var _prev_note_is_e = true

var _step_timer: Timer

func _physics_process(_delta):
	persistent_state.velocity.x = Input.get_axis(GameInput.WALK_LEFT, GameInput.WALK_RIGHT) * PlayerConstants.SPRINT_SPEED * _delta
	super._physics_process(_delta)

func _step():
	if _prev_note_is_e:
		OneShotSound.play(_c_streams.pick_random(), Volume.STEPS)
	else:
		OneShotSound.play(_e_streams.pick_random(), Volume.STEPS)
	_prev_note_is_e = !_prev_note_is_e

func _ready():
	animated_sprite.play(PlayerAnimation.SPRINT)
	
	_step_timer = Timer.new()
	_step_timer.autostart = true
	_step_timer.one_shot = false
	_step_timer.wait_time = 1.0 / 600.0 * 60.0
	_step_timer.timeout.connect(_step)
	add_child(_step_timer)
	_step()
	
func _process(_delta):
	if persistent_state.frozen:
		persistent_state.velocity.x = 0.0
		change_state.call(StateFactory.STATE_IDLE)
		return
	
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
		
	if persistent_state.can_jump() and Input.is_action_pressed(GameInput.JUMP):
		change_state.call(StateFactory.STATE_JUMP_KNEEL)
	elif persistent_state.can_dash() and persistent_state.is_attempting_dash():
		change_state.call(StateFactory.STATE_DASH)
