class_name StateFactory

enum {
	STATE_IDLE,
	STATE_WALK,
	STATE_FALL,
	STATE_JUMP,
	STATE_JUMP_KNEEL,
	STATE_LAND,
	STATE_SPRINT,
	STATE_DASH,
	STATE_DIE,
	STATE_UNLOCKING,
}

var states

func _init():
	states = {
		STATE_IDLE: IdleState,
		STATE_SPRINT: SprintState,
		STATE_WALK: WalkState,
		STATE_JUMP: PlayerJumpState,
		STATE_FALL: PlayerFallState,
		STATE_JUMP_KNEEL: PlayerJumpKneelState,
		STATE_LAND: PlayerLandState,
		STATE_DASH: PlayerDashState,
		STATE_DIE: PlayerDieState,
		STATE_UNLOCKING: PlayerUnlockingState,
}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
