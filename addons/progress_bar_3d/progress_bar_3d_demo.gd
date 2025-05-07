extends Node3D

@onready var _progress_bars:Array[ProgressBar3D] = [
	$BlueBall/ProgressBar3D,
	$RedBall/ProgressBar3D
]

func _on_update_progress_bar_values_timer_timeout() -> void:
	for progress_bar:ProgressBar3D in _progress_bars:
		progress_bar.value = randf_range(progress_bar.min_value, progress_bar.max_value)
