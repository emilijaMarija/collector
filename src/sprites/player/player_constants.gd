extends Node

class_name PlayerConstants

const WALK_SPEED: float = 10000.0
const SPRINT_SPEED: float = 20000.0
const GLIDE_SPEED: float = 7000.0
const PHYSICS_G: float = 9.8 * 1e+2

const JUMP_VELOCITY: float = 500.0
const HIGH_JUMP_VELOCITY: float = JUMP_VELOCITY * 1.2

const MAX_STAMINA: float = 10.0
const STAMINA_REGEN_RATE: float = 1.0
const STAMINA_DEPLETE_RATE: float = 10.0
const MIN_SPRINT_STAMINA_THRESHOLD: float = MAX_STAMINA * 0.5

const DASH_SPEED: float = 50000.0
const DASH_DURATION_SECONDS: float = 0.2
const DASH_COOLDOWN_SECONDS: float = 2.0
