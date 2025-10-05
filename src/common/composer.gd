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

const GROUP_NOTE_PLAYERS = "note-player"

func _ready() -> void:
	pass

func add_note(note: Note):
	assert(!is_note_available(note))
	assert(_soundtracks.has(note))
	_available_notes.append(note)
	
	# Take any player, and get the current offset. If no players are present,
	# start from beginning
	var players = SceneTreeHelper.get_children_in_group(self, GROUP_NOTE_PLAYERS)
	var offset = 0.0
	if players.size() != 0:
		offset = players[0].get_playback_position()
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = _soundtracks[note]
	player.play(offset)
	player.add_to_group(GROUP_NOTE_PLAYERS)
	
func is_note_available(note: Note):
	return _available_notes.has(note)
