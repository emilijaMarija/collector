extends Level

class_name Level1

func _lvl_enter(wp: Waypoint.WP):
	super._lvl_enter(wp)
	if saved_waypoint == Waypoint.WP.SPAWN_POINT:
		# This is the begginning of the game - show intro screen
		var intro_screen = IntroScreen.create()
		add_child(intro_screen)
		intro_screen.end.connect(func():
			remove_child(intro_screen)
			ability_registry.unlock_ability(AbilityRegistry.Ability.WALK)
			composer.add_note(Composer.Note.C)
			)
		pass
