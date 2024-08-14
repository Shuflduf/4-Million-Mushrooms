extends Control

@export var mobile_ui: PackedScene

func _ready() -> void:
	await RenderingServer.frame_post_draw
	if get_viewport().size.x < get_viewport().size.y:
		get_tree().root.add_child(mobile_ui.instantiate())
		queue_free()
