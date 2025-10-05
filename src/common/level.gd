extends Node

class_name Level

const _player_scene = preload("res://sprites/player/player.tscn")

signal exit(waypoint: int)
signal enter(waypoint: int)

var level: int
var ability_registry: AbilityRegistry
var composer: Composer

var ui_layer: CanvasLayer
var player: PlayerStateMachine

const ABILITY_NOTES: Dictionary[Composer.Note, AbilityRegistry.Ability] = {
	Composer.Note.A: AbilityRegistry.Ability.DOUBLE_JUMP,
	Composer.Note.B: AbilityRegistry.Ability.UNLOCK_DOOR,
	Composer.Note.C: AbilityRegistry.Ability.WALK,
	Composer.Note.D: AbilityRegistry.Ability.JUMP,
	Composer.Note.E: AbilityRegistry.Ability.SPRINT,
	Composer.Note.F: AbilityRegistry.Ability.HIGHER_JUMP,
	Composer.Note.G: AbilityRegistry.Ability.DASH,
}

func _spawn_player(waypoint: Waypoint):
	player = PlayerStateMachine.create(ability_registry)
	add_child(player)
	player.global_position = waypoint.global_position
	ui_layer = player.get_node("Camera/UILayer") as CanvasLayer

func _lvl_enter(wp: Waypoint.WP):
	var waypoints = get_tree().get_nodes_in_group(Group.WAYPOINTS) as Array[Waypoint]
	for waypoint in waypoints:
		if waypoint.wp == wp:
			_spawn_player(waypoint)
			break

func _set_up_portals():
	var portals = get_tree().get_nodes_in_group(Group.PORTALS) as Array[Portal]
	for portal in portals:
		portal.body_entered.connect(func(body: Node2D) -> void:
			if body == player:
				exit.emit(portal.target)
				)

func _handle_note_intersect(body: Node2D, note: CollectibleNote) -> void:
	if body != player:
		return
	note.queue_free()
	player.frozen = true
	
	assert(ABILITY_NOTES.has(note.note))
	var ability = ABILITY_NOTES[note.note]
	
	assert(Strings.ABILITY_EXPLANATIONS.has(ability))
	assert(Strings.ABILITY_NAMES.has(ability))
		
	var dialog = UnlockDialog.create(Strings.ABILITY_UNLOCK_HEADER, Composer.get_note_string(note.note), Strings.ABILITY_NAMES[ability], Strings.ABILITY_EXPLANATIONS[ability])
	ui_layer.add_child(dialog)
	dialog.on_dismiss.connect(func() -> void: player.frozen = false)
	
	composer.add_note(note.note)
	
	ability_registry.unlock_ability(ABILITY_NOTES[note.note])

func _set_up_note_interactions():
	for note in get_tree().get_nodes_in_group(Group.NOTES):
		(note as CollectibleNote).body_entered.connect(func (body: Node2D) -> void:
			_handle_note_intersect(body, note))

func _ready() -> void:
	enter.connect(_lvl_enter)
	_set_up_portals()
	_set_up_note_interactions()
