extends Area2D
@onready var tile_map_layer: TileMapLayer = $TileMapLayer



func _on_body_entered(body: Node2D) -> void:
		print("entraste")
		tile_map_layer.visible = true
