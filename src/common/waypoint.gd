extends Node

class_name Waypoint

enum WP {
	TUNNEL,
	SPAWN_POINT,
}

static func get_connection(waypoint: WP) -> Array[int]:
	match waypoint:
		WP.TUNNEL:
			return [LevelFactory.LEVEL_1, LevelFactory.LEVEL_2]
		_:
			assert(false)
			return []

@export var wp: WP


func _ready() -> void:
	assert(is_in_group(Group.WAYPOINTS))
