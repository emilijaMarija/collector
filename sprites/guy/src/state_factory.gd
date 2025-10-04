class_name StateFactory

const STATE_IDLE = "idle"
const STATE_RUN = "run"
const STATE_FALL = "fall"
const STATE_JUMP = "jump"

var states

func _init():
	states = {
		STATE_IDLE: IdleState,
		STATE_RUN: RunState,
		STATE_JUMP: PlayerJumpState,
		STATE_FALL: PlayerFallState,
}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
