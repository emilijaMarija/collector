extends Node

class_name LevelFactory

enum {
	LEVEL_1,
	LEVEL_2,
	LEVEL_3,
	LEVEL_4,
	LEVEL_5,
}

const LEVEL_SCENES: Dictionary[int, PackedScene] = {
	LEVEL_1: preload("res://scenes/level_1.tscn"),
	LEVEL_2: preload("res://scenes/level_2.tscn"),
	LEVEL_3: preload("res://scenes/level_3.tscn"),
	LEVEL_4: preload("res://scenes/level_4.tscn"),
	LEVEL_5: preload("res://scenes/level_5.tscn"),
}

static func create(level: int, ability_registry: AbilityRegistry, composer: Composer) -> Level:
	assert(LEVEL_SCENES.has(level))
	var lvl = LEVEL_SCENES[level].instantiate() as Level
	lvl.ability_registry = ability_registry
	lvl.composer = composer
	lvl.level = level
	return lvl
