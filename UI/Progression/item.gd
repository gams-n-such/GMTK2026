extends Control
class_name Item

@export var icon: Texture2D
@export var dependent_on: Item
@export var modifiers: Array[ModifierInfo] 

var is_available: bool
var is_used: bool


func _ready():
	%Icon.texture = icon
	pass
