extends Node

class_name Strings


const ABILITY_UNLOCK_HEADER = "Unlocked new note"
const ABILITY_NAMES: Dictionary[AbilityRegistry.Ability, String] = {
	AbilityRegistry.Ability.DOUBLE_JUMP: "Double jump",
	AbilityRegistry.Ability.UNLOCK_DOOR: "Unlock doors",
	AbilityRegistry.Ability.WALK: "Walk",
	AbilityRegistry.Ability.JUMP: "Jump",
	AbilityRegistry.Ability.SPRINT: "Sprint",
	AbilityRegistry.Ability.HIGHER_JUMP: "Higher jump",
	AbilityRegistry.Ability.DASH: "Dash",
}
const ABILITY_EXPLANATIONS: Dictionary[AbilityRegistry.Ability, String] = {
	AbilityRegistry.Ability.DOUBLE_JUMP: "Press W while jumping to double-jump",
	AbilityRegistry.Ability.UNLOCK_DOOR: "Press E to unlock nearby doors",
	AbilityRegistry.Ability.WALK: "Press A and D to walk",
	AbilityRegistry.Ability.JUMP: "Press W to jump",
	AbilityRegistry.Ability.SPRINT: "Hold SHIFT while walking to sprint for a short time",
	AbilityRegistry.Ability.HIGHER_JUMP: "You may now jump higher than before",
	AbilityRegistry.Ability.DASH: "Press SPACEBAR to dash",
}
