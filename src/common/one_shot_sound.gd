extends Node

class_name OneShotSound

static func play(stream: AudioStream, volume: float = 1.0):
	assert(stream != null)
	var scene_tree = Engine.get_main_loop() as SceneTree
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.autoplay = true
	player.finished.connect(func(): player.queue_free())
	scene_tree.root.add_child(player)
	player.volume_linear = volume
