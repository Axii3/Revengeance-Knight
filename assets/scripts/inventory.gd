
class_name Inventory



const SIZE: int = 26

@export var items: Array[Item]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _init() -> void:
	for slot in SIZE + 1:
		items.append(Item.new(""))
	pass
	print(items.size())
func get_item(index: int) -> Item:
	return items.get(index)

func add_item(item: Item):
	for i in items.size():
		
		if items.get(i).name == "":
			items.set(i, item)
			
			return
	
