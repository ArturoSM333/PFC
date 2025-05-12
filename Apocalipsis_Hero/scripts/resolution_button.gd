extends MenuButton


func _ready() -> void:
	var popup = $MenuButton.get_popup()  # Obtener el PopupMenu interno
	popup.add_item("Ventana", 1)  # Agregar opción con ID 1
	popup.add_item("Pantalla Completa", 2)  # Agregar opción con ID 2
	popup.connect("id_pressed", self, "_on_menu_option_selected")
	
func _on_menu_option_selected(id: int) -> void:
	match id:
		1:
			print("Seleccionaste Ventana")
		2:
			print("Seleccionaste Pantalla Completa")
