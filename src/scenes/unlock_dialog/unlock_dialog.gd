extends ColorRect

class_name UnlockDialog

signal on_dismiss()

static var _scene: PackedScene = preload("res://scenes/unlock_dialog.tscn")

@onready var _top_text_label: Label = $Container/TopText
@onready var _center_text_label: Label = $Container/CenterText
@onready var _center_bottom_text_label: Label = $Container/CenterBottomLabel
@onready var _bottom_text_label: Label = $Container/BottomLabel

var _top_text: String
var _center_text: String
var _center_bottom_text: String
var _bottom_text: String

@warning_ignore("shadowed_variable")
static func create(top_text: String, center_text: String, center_bottom_text: String, bottom_text: String) -> UnlockDialog:
	var unlock_dialog = _scene.instantiate() as UnlockDialog
	unlock_dialog._top_text = top_text
	unlock_dialog._center_text = center_text
	unlock_dialog._center_bottom_text = center_bottom_text
	unlock_dialog._bottom_text = bottom_text
	return unlock_dialog


func _ready() -> void:
	_change_top_text(_top_text)
	_change_center_text(_center_text)
	_change_center_bottom_text(_center_bottom_text)
	_change_bottom_text(_bottom_text)


func _change_top_text(text: String):
	_top_text_label.text = text


func _change_center_text(text: String):
	_center_text_label.text = text


func _change_center_bottom_text(text: String):
	_center_bottom_text_label.text = text


func _change_bottom_text(text: String):
	_bottom_text_label.text = text


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			queue_free()
			on_dismiss.emit()
