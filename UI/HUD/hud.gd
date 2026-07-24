extends Control


func _ready() -> void:
	Game.player.stun_status_changed.connect(_on_player_stunned)


func _process(delta: float) -> void:
	pass

func set_face_texture(texture: Texture2D):
	var face_display := get_node("%FaceDisplay") as TextureRect
	face_display.texture = texture

@onready var stun_screen: Control = %StunScreen

func _on_player_stunned(stunned: bool) -> void:
	stun_screen.visible = stunned
