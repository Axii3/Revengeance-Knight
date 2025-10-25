extends Control
class_name InventoryUI

@onready var item_slot = preload("res://assets/scenes/item_slot.tscn")

@onready var grid = $inventory/grid
@onready var inventory_overlay = $inventory
@onready var selector = $inventory/Selector

@export var random_item_list: Array[Item]

var inventory: Inventory


var inventory_slots: Array[Control]
var selected_slot: int

const SLOT_WIDTH = 128

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	unselect()
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
			new_slot.inventory_position = slot
			new_slot.inventory_ui = $"."
			inventory_slots.append(new_slot)
			new_slot.update()
		


func close_inventory():
	inventory_overlay.hide()
	for slot in inventory_slots:
		slot.queue_free()
	inventory_slots.clear()

func select_slot(slot: int):
	selector.show()
	selected_slot = slot
	selector.global_position = inventory_slots.get(slot).global_position
	print(selected_slot)
	print(inventory.get_item(selected_slot).name)
	pass

func unselect():
	selector.hide()
	selected_slot = -1

func add_random_item():
	inventory.add_item(random_item_list.get(randi_range(0, random_item_list.size()-1)))
	print(random_item_list.get(randi_range(0, random_item_list.size()-1)))
	update()

func update():
	for slot in inventory_slots:
		slot.queue_free()
	inventory_slots.clear()
	create_inventory()

func _on_button_button_down() -> void:
	add_random_item()
	
	pass # Replace with function body.
	
