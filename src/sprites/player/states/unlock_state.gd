extends State

class_name PlayerUnlockingState

func _on_anim_finish():
	change_state.call(StateFactory.STATE_IDLE)

func _ready():
	animated_sprite.play(PlayerAnimation.UNLOCK)
	animated_sprite.animation_finished.connect(_on_anim_finish)
	
	var doors = get_tree().get_nodes_in_group(Group.DOORS) as Array[Door]
	for door in doors:
		if not door.locked:
			continue
		for body in door.get_overlapping_bodies():
			if body == persistent_state:
				door.unlock.emit()
				break
			
