@tool
class_name ProgressBar3D
extends MeshInstance3D

signal value_changed(new_value)


enum BillboardMode {
	BILLBOARD_DISABLED,
	BILLBOARD_ENABLED,
	BILLBOARD_FIXED_Y,
}



@export var size := Vector2(1, .1) :
	set(v):
		size = v
		_update_mesh()
@export var value := 50.0 :
	set(v):
		value = clampf(v, min_value, max_value)
		_update_shader()
		value_changed.emit(value)
@export var min_value := 0.0 :
	set(v):
		min_value = v
		_update_shader()
@export var max_value := 100.0 :
	set(v):
		max_value = v
		_update_shader()
@export var background_color := Color.BLACK :
	set(v):
		background_color = v
		_update_shader()
@export var progress_color := Color.GREEN :
	set(v):
		progress_color = v
		_update_shader()


func _update_mesh() -> void:
	var qm:QuadMesh = mesh
	qm.size = size


func _update_shader() -> void:
	var progress_value := (value-min_value) / (max_value - min_value)
	var mat:ShaderMaterial = mesh.material
	mat.set_shader_parameter("progress_value", progress_value)
	mat.set_shader_parameter("progress_color", progress_color)
	mat.set_shader_parameter("background_color", background_color)


func _enter_tree() -> void:
	if !mesh:
		mesh = QuadMesh.new()
		mesh.size = Vector2(1.0, .1)
		var mat := ShaderMaterial.new()
		mesh.material = mat
		var shader: Shader = load("res://addons/progress_bar_3d/progress_bar_3d.gdshader").duplicate()
		mat.shader = shader

