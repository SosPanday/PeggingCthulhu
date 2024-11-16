class_name Room
extends Resource

enum Type {NOT_ASSIGNED, ENEMY, KEYLOCK, TREASURE, SHOP}

@export var type: Type
@export var row: int
@export var column: int
@export var pos: Vector2
@export var nextRooms: Array[Room]
@export var select := false

func _to_string() -> String:
	return "%s (%s)" % [column,Type.keys()[type][0]]
	
