extends Label

func _ready() -> void:
	if Game.combo_manager:
		Game.combo_manager.combo_changed.connect(_on_combo_changed)
		Game.combo_manager.combo_broken.connect(_on_combo_broken)
		_update_combo_text(Game.combo_manager.get_combo())

func _exit_tree() -> void:
	if Game.combo_manager:
		Game.combo_manager.combo_changed.disconnect(_on_combo_changed)
		Game.combo_manager.combo_broken.disconnect(_on_combo_broken)

func _on_combo_changed(_old_value: int, new_value: int) -> void:
	_update_combo_text(new_value)

func _on_combo_broken(_previous_combo: int) -> void:
	text = "Combo BROKEN: %d" % [0]

func _update_combo_text(value: int) -> void:
	text = "Combo: %d" % [value]
