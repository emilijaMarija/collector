extends Area2D

class_name Portal

@export var target: Waypoint.WP

func _ready() -> void:
	assert(is_in_group(Group.PORTALS))
