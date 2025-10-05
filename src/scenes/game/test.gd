extends Node

@onready var _ability_registry: AbilityRegistry = $AbilityRegistry
@onready var _node_composer: Composer = $Composer
@onready var _node_ui_layer: CanvasLayer = $Camera/UILayer
@onready var _node_player: PlayerStateMachine = $Player

const ABILITY_NOTES: Dictionary[Composer.Note, AbilityRegistry.Ability] = {
	Composer.Note.A: AbilityRegistry.Ability.DOUBLE_JUMP,
	Composer.Note.B: AbilityRegistry.Ability.UNLOCK_DOOR,
	Composer.Note.C: AbilityRegistry.Ability.WALK,
	Composer.Note.D: AbilityRegistry.Ability.JUMP,
	Composer.Note.E: AbilityRegistry.Ability.SPRINT,
	Composer.Note.F: AbilityRegistry.Ability.HIGHER_JUMP,
	Composer.Note.G: AbilityRegistry.Ability.DASH,
}

func _handle_note_intersect(body: Node2D, note: CollectibleNote) -> void:
	if body != _node_player:
		return
	note.queue_free()
	_node_player.frozen = true
	
	assert(ABILITY_NOTES.has(note.note))
	var ability = ABILITY_NOTES[note.note]
	
	assert(Strings.ABILITY_EXPLANATIONS.has(ability))
	assert(Strings.ABILITY_NAMES.has(ability))
		
	var dialog = UnlockDialog.create(Strings.ABILITY_UNLOCK_HEADER, Composer.get_note_string(note.note), Strings.ABILITY_NAMES[ability], Strings.ABILITY_EXPLANATIONS[ability])
	_node_ui_layer.add_child(dialog)
	dialog.on_dismiss.connect(func() -> void: _node_player.frozen = false)
	
	_node_composer.add_note(note.note)
	
	_ability_registry.unlock_ability(ABILITY_NOTES[note.note])

func _ready() -> void:
	for note in get_tree().get_nodes_in_group(Group.NOTES):
		(note as CollectibleNote).body_entered.connect(func (body: Node2D) -> void:
			_handle_note_intersect(body, note))
