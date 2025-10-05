extends Node

class_name SceneTreeHelper

static func get_children_in_group(parent: Node, group_name: String) -> Array:
	return parent.get_children().filter(func(c): return c.is_in_group(group_name))
