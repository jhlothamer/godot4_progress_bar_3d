@tool
@icon("res://addons/progress_bar_3d/progress_bar_3d.svg")
class_name ProgressBar3D
extends MeshInstance3D
## A progress bar in 3D.  Implemented using a single quad mesh and a shader (no vieports).


## Emitted when value has been changed.
signal value_changed(new_value)


## Duplicate of BaseMaterial3D's BillboardMode enum (except particle option).
enum BillboardMode {
	BILLBOARD_DISABLED,
	BILLBOARD_ENABLED,
	BILLBOARD_FIXED_Y,
}


## Size of quad mesh used for progress bar.
@export var size := Vector2(1, .1) :
	set(v):
		size = v
		_update_mesh()
## Current value.
@export var value := 50.0 :
	set(v):
		value = clampf(v, min_value, max_value)
		_update_shader_parameters()
		value_changed.emit(value)
## Minimum value.
@export var min_value := 0.0 :
	set(v):
		min_value = v
		_update_shader_parameters()
## Maximum value.
@export var max_value := 100.0 :
	set(v):
		max_value = v
		_update_shader_parameters()
## Background color.
@export var background_color := Color.BLACK :
	set(v):
		background_color = v
		_update_shader_parameters()
## Fill color.
@export var progress_color := Color.GREEN :
	set(v):
		progress_color = v
		_update_shader_parameters()
## Turns on, off shading of quad mesh.
@export var unshaded := true :
	set(v):
		unshaded = v
		_update_shader()
## Turns on, off shadows of quad mesh.
@export var shadows_disabled := true :
	set(v):
		shadows_disabled = v
		_update_shader()
## Turns on, off depth test of quad mesh.
@export var depth_test_disabled := true :
	set(v):
		depth_test_disabled = v
		_update_shader()
## Sets the quad mesh to face the camera (enabled), face camera but remain upright
## (fixed y) or disabled.
@export var billboard_mode:BillboardMode = BillboardMode.BILLBOARD_ENABLED :
	set(v):
		billboard_mode = v
		_update_shader_parameters()


# update mesh size
func _update_mesh() -> void:
	var qm:QuadMesh = mesh
	qm.size = size


# update shader params
func _update_shader_parameters() -> void:
	var progress_value := (value-min_value) / (max_value - min_value)
	var mat:ShaderMaterial = mesh.material
	mat.set_shader_parameter("progress_value", progress_value)
	mat.set_shader_parameter("progress_color", progress_color)
	mat.set_shader_parameter("background_color", background_color)
	mat.set_shader_parameter("billboard_mode", billboard_mode)


# replace the render_mode line in the progress_bar_3d.gdshader
func _update_shader() -> void:
	var mat:ShaderMaterial = mesh.material
	mesh.material = mat
	var shader: Shader = load("res://addons/progress_bar_3d/progress_bar_3d.gdshader").duplicate()
	var code:String = shader.code
	var render_mode := ""
	if unshaded:
		render_mode += "unshaded";
	if shadows_disabled:
		if !render_mode.is_empty():
			render_mode += ", "
		render_mode += "shadows_disabled";
	if depth_test_disabled:
		if !render_mode.is_empty():
			render_mode += ", "
		render_mode += "depth_test_disabled";
	if !render_mode.is_empty():
		render_mode = "render_mode %s;" % render_mode
	shader.code = code.replace("render_mode unshaded, shadows_disabled, depth_test_disabled;", render_mode)
	mat.shader = shader


# create mesh duplicate shader on entering the node tree
func _enter_tree() -> void:
	mesh = QuadMesh.new()
	mesh.size = size
	var mat := ShaderMaterial.new()
	mesh.material = mat
	mesh.resource_local_to_scene = true
	var shader: Shader = load("res://addons/progress_bar_3d/progress_bar_3d.gdshader").duplicate()
	mat.shader = shader
	_update_shader_parameters()

