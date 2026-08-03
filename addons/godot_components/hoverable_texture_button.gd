extends TextureButton

class_name HoverableTextureButton

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	modulate.a  = 0.75 
	pass

func _on_mouse_exited() -> void:
	modulate.a  = 1
	pass
