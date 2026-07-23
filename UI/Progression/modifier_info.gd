extends Node
class_name ModifierInfo

enum ModifierType { DAMAGE, HP, SPEED }

@export var mod_name: String
@export var type: ModifierType
@export var mod: DynamicAttribute
