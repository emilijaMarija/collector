extends Node

func _ready() -> void:
	($Composer as Composer).add_note(Composer.Note.C)
	await get_tree().create_timer(5).timeout
	($Composer as Composer).add_note(Composer.Note.D)
	await get_tree().create_timer(5).timeout
	($Composer as Composer).add_note(Composer.Note.E)
	await get_tree().create_timer(5).timeout
	($Composer as Composer).add_note(Composer.Note.F)
	await get_tree().create_timer(5).timeout
	($Composer as Composer).add_note(Composer.Note.G)
	await get_tree().create_timer(5).timeout
	($Composer as Composer).add_note(Composer.Note.A)
	await get_tree().create_timer(5).timeout
	($Composer as Composer).add_note(Composer.Note.B)
