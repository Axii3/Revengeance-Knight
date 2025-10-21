extends Control

@onready var item_slot = preload("res://assets/scenes/item_slot.tscn")

@onready var grid = $inventory/grid
@onready var inventory_overlay = $inventory

var inventory: Inventory


var inventory_slots: Array[Control]


const SLOT_WIDTH = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_inventory():
	inventory_overlay.show()
	for slot in inventory.SIZE:
		if inventory.get_item(slot).name != "":
			var new_slot = item_slot.instantiate()
			grid.add_child(new_slot)
			new_slot.custom_minimum_size.x = SLOT_WIDTH
			new_slot.custom_minimum_size.y = SLOT_WIDTH
			new_slot.icon = inventory.get_item(slot).icon
			inventory_slots.append(new_slot)
		


func close_inventory():
	inventory_overlay.hide()
	for slot in inventory_slots:
		slot.queue_free()
	inventory_slots.clear()
