extends Node

@export var balls: int = 12

# Signal für Änderungen der Ballanzahl
signal ball_count_changed(new_count)

# Getter für die Ballanzahl
func get_balls() -> int:
	return balls

# Ballanzahl ändern (wird vom Setter ausgelöst)
func _on_ball_count_changed():
	emit_signal("ball_count_changed", balls)

# Füge einen Ball hinzu
func add_ball():
	balls += 1
	_on_ball_count_changed()

# Entferne einen Ball
func remove_ball():
	if balls > 0:
		balls -= 1
		_on_ball_count_changed()
		
