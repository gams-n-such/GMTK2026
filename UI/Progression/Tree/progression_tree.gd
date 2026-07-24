class_name ProgressionTreeControl
extends Control


signal purchase_requested(source: ProgressionLeafControl)

const arrow : PackedScene = preload("res://UI/Progression/Tree/arrow.tscn")

func _ready() -> void:
	for leaf in get_children():
		if leaf is ProgressionLeafControl:
			(leaf as ProgressionLeafControl).trying_to_purchase.connect(_on_item_trying_to_purchase)
			if leaf.dependent_on != null:
				var start: Vector2 = leaf.dependent_on.global_position + leaf.dependent_on.size / 2
				var end: Vector2 = leaf.global_position + leaf.size / 2
				var arr: Control = arrow.instantiate()
				var angle: float = start.angle_to_point(end)
				leaf.dependent_on.add_child(arr)
				arr.position = Vector2(arr.get_parent().size.x / 2, -arr.get_parent().size.y / 2 + arr.size.y / 15)
				#arr.position += Vector2(cos(angle), sin(angle)) * arr.get_parent().size.x / 2
				arr.size.x = start.distance_to(end)
				arr.rotation = angle


func _on_item_trying_to_purchase(leaf: ProgressionLeafControl) -> void:
	purchase_requested.emit(leaf)
