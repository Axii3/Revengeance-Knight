
class_name Inventory



const SIZE: int = 26

@export var items: Array[Item]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _init() -> void:
	for slot in SIZE + 1:
		items.append(Item.new(""))
	items.append(Item.new(""))
	pass
	print(items.size())
func get_item(index: int) -> Item:
	return items.get(index)

func add_item(item: Item):
	for i in SIZE + 1:
		
		if items.get(i).name == "":
			items.set(i, item)
			
			return
func swap_item(item1:int, item2:int):
	var temp_item: Item = get_item(item1)
	items[item1] = get_item(item2)
	items[item2] = temp_item
	
