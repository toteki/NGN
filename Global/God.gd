extends Node

# Commandments:
# - Set this script to autoload in project settings
# 	- !!! Or not? If we make everything static...
# - Enable advanced project settings
# - Enable every single GDSCript debug setting as Error
# - Set safe lines to 00FF00 and enable in editor settings

var console_min_log_level:int = 0

# A strongly typed global logger signal
signal Logger(level:int, message:String)

# Called on autoload
func _ready() -> void:
	Check(Logger.connect(Log)) # Connect logger to signal

# Automatically connected to message_logged signal
func Log(level: int, message:String) -> void:
	if level >= console_min_log_level:
		print("Log",level,":", message)

# Use anywhere in the code an error return value would be discarded
func Check(err: Error) -> void:
	if err != OK:
		print("Check: ",err)
		push_error(err) # Distinguished from print, has stack trace
