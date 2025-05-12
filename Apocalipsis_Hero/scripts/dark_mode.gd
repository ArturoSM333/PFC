extends CheckButton

@onready var color_rect: ColorRect = $ColorRect


func _on_pressed() -> void:
	color_rect.visible = not color_rect.visible
