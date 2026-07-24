class_name ComboManager
extends Node

@export var decay_started : bool = false
signal combo_changed(old_value: int, new_value: int)
signal combo_broken(previous_combo: int)

var current_combo := 0
var current_level := 0
var _decay_progress := 0.0
var config: SmashComboConfig

func _process(delta: float) -> void:
	if decay_started:
		_apply_decay_tick(delta)


func get_current_level() -> SmashComboLevelConfig:
	return config.levels.get(current_level)

func initialize(combo_config: SmashComboConfig) -> void:
	config = combo_config

func add_combo(amount := 1) -> void:
	var old := current_combo
	current_combo += amount
	combo_changed.emit(old, current_combo)

func reset_combo() -> void:
	if current_combo == 0:
		return

	var old := current_combo
	current_combo = 0

	combo_broken.emit(old)
	combo_changed.emit(old, current_combo)

func get_combo() -> int:
	return current_combo
	
func _apply_decay_tick(delta: float):
	if current_combo != 0:
		_decay_progress += get_current_level().cooling_rate * delta
		if _decay_progress >= 1.0:
			var lost := int(_decay_progress)
			_decay_progress -= lost
			var old := current_combo
			current_combo = max(current_combo - lost, 0)
			if old != current_combo:
				combo_changed.emit(old, current_combo)
			if current_combo == 0:
				combo_broken.emit(old)
