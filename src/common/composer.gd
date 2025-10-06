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
var _started_playing: float

const GROUP_NOTE_PLAYERS = "note-player"

func _ready() -> void:
	pass

func add_note(note: Note):
	assert(!is_note_available(note))
	assert(_soundtracks.has(note))
	_available_notes.append(note)
	
	# Take any player, and get the current offset. If no players are present,
	# start from beginning
	if _started_playing == 0:
		_started_playing = Time.get_unix_time_from_system()
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = _soundtracks[note]
	player.volume_linear = Volume.BACKGROUND_MUSIC
	player.play(Time.get_unix_time_from_system() - _started_playing)
	player.add_to_group(GROUP_NOTE_PLAYERS)
	
func is_note_available(note: Note):
	return _available_notes.has(note)
