extends Node

class_name PlayerStateMachine

const _scene = preload("res://sprites/player/player.tscn")
var _ability_registry: AbilityRegistry

var num_jumps = 0
var stamina = PlayerConstants.MAX_STAMINA
var last_dash: float = 0
var frozen = false
var state_name: int

var _state: State
var _state_factory: StateFactory

static func create(ability_registry: AbilityRegistry) -> PlayerStateMachine:
	var node = _scene.instantiate()
	node._ability_registry = ability_registry
	return node

func can_jump():
	if not _ability_registry.has_ability(AbilityRegistry.Ability.JUMP):
		return false
	var has_double_jump = _ability_registry.has_ability(AbilityRegistry.Ability.DOUBLE_JUMP)
	if has_double_jump:
		return num_jumps <= 1
	
	return _state.persistent_state.is_on_floor()
	
func can_dash():
	var cooldown_passed = Time.get_unix_time_from_system() - last_dash >= PlayerConstants.DASH_COOLDOWN_SECONDS
	return cooldown_passed and _ability_registry.has_ability(AbilityRegistry.Ability.DASH)

func can_sprint():
	return _ability_registry.has_ability(AbilityRegistry.Ability.SPRINT) and stamina >= PlayerConstants.MIN_SPRINT_STAMINA_THRESHOLD
	
func can_unlock():
	return _ability_registry.has_ability(AbilityRegistry.Ability.UNLOCK_DOOR)

func is_attempting_dash():
	return Input.is_action_just_pressed(GameInput.DASH)

func has_ability(ability: AbilityRegistry.Ability):
	return _ability_registry.has_ability(ability)

func can_walk():
	return _ability_registry.has_ability(AbilityRegistry.Ability.WALK)

func _ready():
	_state_factory = StateFactory.new()
	change_state(StateFactory.STATE_IDLE)

func _physics_process(_delta: float):
	stamina += PlayerConstants.STAMINA_REGEN_RATE * _delta
	stamina = min(stamina, PlayerConstants.MAX_STAMINA)

func change_state(new_state_name: int):
	if _state != null:
		_state.queue_free()
	_state = _state_factory.get_state(new_state_name).new()
	_state.setup(Callable(self, "change_state"), $AnimatedSprite2D, self)
	add_child(_state)
	state_name = new_state_name
