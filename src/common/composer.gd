extends Node

class_name Composer

enum Note {
	A,
	B,
	C,
	D,
	E,
	F,
	G
}


static func get_note_string(note: Note) -> String:
	match note:
		Note.A:
			return "A"
		Note.B:
			return "B"
		Note.C:
			return "C"
		Note.D:
			return "D"
		Note.E:
			return "E"
		Note.F:
			return "F"
		Note.G:
			return "G"
		_:
			assert(false, "unknown note given")
			return ""


var _soundtracks = {
	Note.A: preload("res://sound/music/A.wav"),
	Note.B: preload("res://sound/music/B.wav"),
	Note.C: preload("res://sound/music/C.wav"),
	Note.D: preload("res://sound/music/D.wav"),
	Note.E: preload("res://sound/music/E.wav"),
	Note.F: preload("res://sound/music/F.wav"),
	Note.G: preload("res://sound/music/G.wav")
}

var _available_notes: Array[Note] = []

func _ready() -> void:
	pass
	
func start():
	for note in _soundtracks.keys():
		var player = AudioStreamPlayer.new()
		add_child(player)
		player.stream = _soundtracks[note]
		player.volume_linear = 0
		player.play()
		player.add_to_group(Group.NOTE_AUDIO_PLAYERS)

func add_note(note: Note):
	assert(!is_note_available(note))
	assert(_soundtracks.has(note))
	_available_notes.append(note)
	
	for player in get_tree().get_nodes_in_group(Group.NOTE_AUDIO_PLAYERS):
		if player.stream == _soundtracks[note]:
			player.volume_linear = Volume.BACKGROUND_MUSIC
	
func is_note_available(note: Note):
	return _available_notes.has(note)
