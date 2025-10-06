extends Area2D

class_name SavePoint

@export var waypoint: Waypoint.WP

func _ready():
	assert(is_in_group(Group.SAVE_POINTS))
