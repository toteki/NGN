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

static var Console_min_log_level:int = 0

# Main game layers. Instantiated via code.
static var UI:CanvasLayer = null
static var World:CanvasLayer = null
static var BG:CanvasLayer = null

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

# !
#
#	TODO: Static functions don't need to be autoloaded.
#	So create classes to hold helpers or such things.
#
# !

# Instantiate a Node2D scene and add it to a parent
static func AddChild2D(
	scene:PackedScene,
	parent:Node,
	x:float = 0,
	y:float = 0,
	rotation:float = 0,
	) -> void:
	# var r:Resource = load(scene path)
	# assert(r is PackedScene)
	var n:Node = scene.instantiate()
	assert(n is Node2D)
	var n2d:Node2D = n as Node2D
	n2d.translate(Vector2(x,y))
	n2d.rotate(rotation)
	parent.add_child(n)

# Automatically connected to message_logged signal
static func Log(level: int, message:String) -> void:
	if level >= Console_min_log_level:
		print("Log",level,":", message)

# Use anywhere in the code an error would be discarded
static func Check(err: Error) -> void:
	if err != OK:
		print("Check: ",err)
		push_error(err) # Has stack trace
