extends Node

class_name Level

const _player_scene = preload("res://sprites/player/player.tscn")

signal exit(waypoint: int)
signal enter(waypoint: int)

var level: int
var saved_waypoint: Waypoint.WP
var ability_registry: AbilityRegistry
var composer: Composer

var ui_layer: CanvasLayer
var player: PlayerStateMachine
var camera: Camera2D

const ABILITY_NOTES: Dictionary[Composer.Note, AbilityRegistry.Ability] = {
	Composer.Note.A: AbilityRegistry.Ability.DOUBLE_JUMP,
	Composer.Note.B: AbilityRegistry.Ability.UNLOCK_DOOR,
	Composer.Note.C: AbilityRegistry.Ability.WALK,
	Composer.Note.D: AbilityRegistry.Ability.JUMP,
	Composer.Note.E: AbilityRegistry.Ability.SPRINT,
	Composer.Note.F: AbilityRegistry.Ability.HIGHER_JUMP,
	Composer.Note.G: AbilityRegistry.Ability.DASH,
}

# How long to show player after death
const DIE_DELAY_SECONDS: float = 1.5

func _spawn_player(waypoint: Waypoint):
	player = PlayerStateMachine.create(ability_registry)
	ui_layer = player.get_node("Camera/UILayer") as CanvasLayer
	camera = player.get_node("Camera") as Camera2D
	player.global_position = waypoint.global_position
	add_child(player)
	
	# Re-enable camera smoothing after a short delay
	get_tree().create_timer(0.1).timeout.connect(func(): camera.position_smoothing_enabled = true)

func _die():
	if player.state_name == StateFactory.STATE_DIE:
		# Player is already dead
		return
	player.change_state(StateFactory.STATE_DIE)
	get_tree().create_timer(DIE_DELAY_SECONDS).timeout.connect(func():
		remove_child(player)
		_spawn_player(_find_waypoint(saved_waypoint))
		)

func _find_waypoint(wp: Waypoint.WP) -> Waypoint:
	var waypoints = get_tree().get_nodes_in_group(Group.WAYPOINTS) as Array[Waypoint]
	for waypoint in waypoints:
		if waypoint.wp == wp:
			return waypoint
	assert(false, "no matching waypoint found in level. wp ID: %d" % wp)
	return null

func _lvl_enter(wp: Waypoint.WP):
	saved_waypoint = wp
	_spawn_player(_find_waypoint(wp))

func _emit_exit(target: Waypoint.WP):
	exit.emit(target)

func _set_up_portals():
	var portals = get_tree().get_nodes_in_group(Group.PORTALS) as Array[Portal]
	for portal in portals:
		portal.body_entered.connect(func(body: Node2D) -> void:
			if body == player:
				call_deferred("_emit_exit", portal.target)
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

func _set_up_notes():
	for note in get_tree().get_nodes_in_group(Group.NOTES):
		if ability_registry.has_ability(ABILITY_NOTES[note.note]):
			# Remove notes which have already been collected
			note.queue_free()
			continue
		(note as CollectibleNote).body_entered.connect(func (body: Node2D) -> void:
			_handle_note_intersect(body, note))

func _set_up_lethal_areas():
	var areas = get_tree().get_nodes_in_group(Group.LETHAL_AREAS) as Array[Area2D]
	for area in areas:
		assert(area is Area2D)
		area.body_entered.connect(func(body: Node2D):
			if body == player:
				call_deferred("_die"))

func _set_up_save_points():
	var nodes = get_tree().get_nodes_in_group(Group.SAVE_POINTS) as Array[SavePoint]
	for save_point in nodes:
		save_point.body_entered.connect(func(body: Node2D):
			if body == player:
				saved_waypoint = save_point.waypoint)

func _ready() -> void:
	enter.connect(_lvl_enter)
	_set_up_portals()
	_set_up_lethal_areas()
	_set_up_notes()
	_set_up_save_points()
