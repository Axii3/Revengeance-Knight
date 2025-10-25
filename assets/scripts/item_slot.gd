extends Control

var icon: Texture2D
@onready var texture_rect = $TextureRect

var inventory_ui: InventoryUI
var inventory_position: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update() -> void:
	texture_rect.texture = icon

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			inventory_ui.select_slot(inventory_position)
	pass # Replace with function body.
