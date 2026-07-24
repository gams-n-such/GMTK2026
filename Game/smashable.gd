class_name Smashable
extends Node3D

@export var data : SmashableResource = null

@onready var max_health: SimpleAttribute = %MaxHealth
@onready var health: SimpleAttribute = %Health
@onready var damage: SimpleAttribute = %Damage
@onready var reward: SimpleAttribute = %Reward

signal destroyed(target: Smashable)
var _destroyed : bool = false
var _view : Node3D = null

@onready var placeholder_mesh: MeshInstance3D = $PlaceholderMesh

func _ready() -> void:
	apply_stats(data)
	# TODO: implement SmashableViews
	_view = placeholder_mesh

func _process(delta: float) -> void:
	pass

func apply_stats(stats: SmashableResource) -> void:
	assert(stats)
	max_health.set_value(stats.health)
	health.set_value(stats.health)
	damage.set_value(stats.damage)
	reward.set_value(stats.reward)

func calculate_damage(base_amount: float, state: Dictionary = {}) -> float:
	var multiplier: float = 1.0
	if state.has("buff_multiplier"):
		multiplier *= float(state["buff_multiplier"])
	if state.has("debuff_multiplier"):
		multiplier *= float(state["debuff_multiplier"])
	return base_amount * multiplier

func apply_damage(amount: float) -> void:
	take_damage(amount)

func _on_hit_occurred(attacker: Node, target: Node) -> void:
	if target == self and attacker is SmashPlayerState:
		var self_damage := (attacker as SmashPlayerState).calculate_damage((attacker as SmashPlayerState).damage.value, {"debuff_multiplier": 1.0})
		apply_damage(self_damage)

func take_damage(amount: float) -> void:
	health.add(-amount)

func _on_health_value_changed(attribute: Attribute, new_value: float, old_value: float) -> void:
	if not _destroyed:
		#print("Smashable HP left: %f" % [new_value])
		if new_value <= 0.0:
			_destroyed = true
			_view.visible = false
			destroyed.emit(self)
