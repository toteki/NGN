extends Node

# Commandments:
# - Set this script to autoload in project settings
# - Enable advanced project settings
# - Enable every single GDSCript debug setting as Error
# - Safe lines to 00FF00 and enable in editor settings

# Style Notes:
# - I capitalize my fields to distinguish from built-in

# A strongly typed global logger signal
signal Logger(level:int, message:String)

var Console_min_log_level:int = 0

# Main game layers. Instantiated via code.
var UI:CanvasLayer = null
var World:CanvasLayer = null
var BG:CanvasLayer = null

# Called on autoload
func _ready() -> void:
	# Connect logger to signal
	Check(Logger.connect(Log))
	
	# Add game layers
	UI = CanvasLayer.new()
	World = CanvasLayer.new()
	BG = CanvasLayer.new()
	UI.layer = 1
	World.layer = 0
	BG.layer = -1
	add_child(BG)
	add_child(World)
	add_child(UI)

# Automatically connected to message_logged signal
func Log(level: int, message:String) -> void:
	if level >= Console_min_log_level:
		print("Log",level,":", message)

# Use anywhere in the code an error would be discarded
func Check(err: Error) -> void:
	if err != OK:
		print("Check: ",err)
		push_error(err) # Has stack trace
