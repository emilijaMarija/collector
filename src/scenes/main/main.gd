extends Node

var _scene_game = preload("res://scenes/game.tscn")

func _ready() -> void:
	add_child(_scene_game.instantiate())
