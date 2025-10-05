extends ColorRect

class_name UnlockDialog

static var scene: PackedScene = preload("res://scenes/unlock_dialog.tscn")

@onready var top_text_label: Label = $Container/TopText
@onready var center_text_label: Label = $Container/CenterText
@onready var center_bottom_text_label: Label = $Container/CenterBottomLabel
@onready var bottom_text_label: Label = $Container/BottomLabel

var top_text: String
var center_text: String
var center_bottom_text: String
var bottom_text: String

@warning_ignore("shadowed_variable")
static func create(top_text: String, center_text: String, center_bottom_text: String, bottom_text: String) -> UnlockDialog:
	var unlock_dialog = scene.instantiate() as UnlockDialog
	unlock_dialog.top_text = top_text
	unlock_dialog.center_text = center_text
	unlock_dialog.center_bottom_text = center_bottom_text
	unlock_dialog.bottom_text = bottom_text
	return unlock_dialog


func _ready() -> void:
	_change_top_text(top_text)
	_change_center_text(center_text)
	_change_center_bottom_text(center_bottom_text)
	_change_bottom_text(bottom_text)


func _change_top_text(text: String):
	top_text_label.text = text


func _change_center_text(text: String):
	center_text_label.text = text


func _change_center_bottom_text(text: String):
	center_bottom_text_label.text = text


func _change_bottom_text(text: String):
	bottom_text_label.text = text


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			queue_free()
