extends Area2D

class_name Door

@onready var _info_tooltip: Label = $InfoTooltip
@onready var _door_sprite: Sprite2D = $Sprite

const _unlocked_texture: Texture2D = preload("res://sprites/map/door/door.png")
const _locked_texture: Texture2D = preload("res://sprites/map/door/door_lock.png")

@export var locked = false
signal unlock()

func _player_nearby(player: PlayerStateMachine):
	if player.has_ability(AbilityRegistry.Ability.UNLOCK_DOOR):
		_info_tooltip.visible = true

func _update_texture():
	if locked:
		_door_sprite.texture = _locked_texture
	else:
		_door_sprite.texture = _unlocked_texture

func _player_exited(player: PlayerStateMachine):
	_info_tooltip.visible = false

func _handle_unlock():
	assert(locked)
	locked = false
	_update_texture()
	_info_tooltip.visible = false

func _ready():
	_update_texture()
	unlock.connect(_handle_unlock)
	body_entered.connect(func(body: Node):
		if body.is_in_group(Group.PLAYER):
			_player_nearby(body as PlayerStateMachine)
		)
	body_exited.connect(func(body: Node):
		if body.is_in_group(Group.PLAYER):
			_player_exited(body as PlayerStateMachine)
		)
