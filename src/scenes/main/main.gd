extends Node

@onready var _ability_registry = $AbilityRegistry
@onready var _composer = $Composer

var _lvl: Level

func _switch_level(target_level: int):
	if _lvl != null:
		remove_child(_lvl)
	_lvl = LevelFactory.create(target_level, _ability_registry, _composer)
	_lvl.exit.connect(_lvl_exit)
	add_child(_lvl)
	await _lvl.ready

func _lvl_exit(waypoint: int):
	var connection = Waypoint.get_connection(waypoint)
	var target_lvl: int
	for conn in connection:
		if conn != _lvl.level:
			target_lvl = conn
			break
	_switch_level(target_lvl)
	_lvl.enter.emit(waypoint)

func _ready() -> void:
	_switch_level(LevelFactory.LEVEL_1)
	_lvl.enter.emit(Waypoint.WP.SPAWN_POINT)
	
