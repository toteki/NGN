extends Node

# Automatically connected to the signal named "pressed"
func _pressed() -> void:
	God.Logger.emit(1,"INIT")
