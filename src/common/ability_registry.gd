extends Node

class_name AbilityRegistry

enum Ability {
	SPRINT,
	DASH,
	DOUBLE_JUMP,
	HIGHER_JUMP
}

var _unlocked_abilities: Array[Ability] = [Ability.SPRINT, Ability.DOUBLE_JUMP, Ability.HIGHER_JUMP, Ability.DASH]

func has_ability(ability: Ability):
	return _unlocked_abilities.has(ability)

func unlock_ability(ability: Ability):
	assert(!has_ability(ability))
	_unlocked_abilities.append(ability)
