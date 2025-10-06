extends Node

class_name Waypoint

enum WP {
	TUNNEL,
	SPAWN_POINT,
	SPIKY_WALKWAY,
	SPIKY_TUNNEL,
	ROOTS_WALKWAY,
}

static func get_connection(waypoint: WP) -> Array[int]:
	match waypoint:
		WP.TUNNEL:
			return [LevelFactory.LEVEL_1, LevelFactory.LEVEL_2]
		WP.SPIKY_WALKWAY:
			return [LevelFactory.LEVEL_1, LevelFactory.LEVEL_3]
		WP.SPIKY_TUNNEL:
			return [LevelFactory.LEVEL_4, LevelFactory.LEVEL_3]
		WP.ROOTS_WALKWAY:
			return [LevelFactory.LEVEL_4, LevelFactory.LEVEL_2]
		_:
			assert(false)
			return []

@export var wp: WP


func _ready() -> void:
	assert(is_in_group(Group.WAYPOINTS))
