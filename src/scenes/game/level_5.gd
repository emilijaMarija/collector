extends Level

@onready var _door = $Door
@onready var _locked_portal = $LockedPortal

func _locked_portal_intersect(body: Node2D):
	if body != player:
		return
	if _door.locked:
		return
	call_deferred("_exit_with_end_tunnel")

func _ready() -> void:
	super._ready()
	_locked_portal.body_entered.connect(_locked_portal_intersect)


func _exit_with_end_tunnel():
	exit.emit(Waypoint.WP.END_TUNNEL)
