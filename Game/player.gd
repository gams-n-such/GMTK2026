class_name SmashPlayer
extends Node3D

@onready var camera_pivot: Node3D = %CameraPivot
@onready var camera: Camera3D = %Camera3D

signal hit

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	pass


func _on_hit_occurred(attacker: Node, target: Node) -> void:
	pass

#region Input

var _last_mouse_direction: int = 0



func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var direction: int = signi(event.relative.y)
		if direction == 0:
			return
		if direction == 1 and _last_mouse_direction == -1:
			hit.emit()
		_last_mouse_direction = direction

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		Game.open_pause_menu()
	
	# Mouse input
	_mouse_moving = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if _mouse_moving:
		var mouse_event = event as InputEventMouseMotion
		_input_yaw = -mouse_event.relative.x * mouse_sensitivity
		_input_pitch = -mouse_event.relative.y * mouse_sensitivity


const MIN_TILT = deg_to_rad(-90)
const MAX_TILT = deg_to_rad(90)

var _mouse_moving : bool = false
var _input_yaw : float
var _input_pitch : float
var _mouse_rotation : Vector3
var _player_rotation : Vector3
var _camera_rotation : Vector3
@export var mouse_sensitivity : float = 0.5

var _saved_yaw_input : float

func _process_camera(delta : float) -> void:
	_saved_yaw_input = _input_yaw
	_mouse_rotation.x += _input_pitch * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, MIN_TILT, MAX_TILT)
	_mouse_rotation.y += _input_yaw * delta
	
	_player_rotation = Vector3(0, _mouse_rotation.y, 0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0, 0)
	#
	#CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	#CAMERA_CONTROLLER.rotation.z = 0
	
	# TODO: revisit
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	_input_pitch = 0
	_input_yaw = 0

#endregion

#region Camera

#endregion
