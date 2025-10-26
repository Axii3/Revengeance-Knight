extends Resource

class_name Item

@export var name: String = ""
@export var icon: Texture2D
@export var description: String = ""

func _init(name = ""):
	name = name
