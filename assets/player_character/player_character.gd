extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.002

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var inventory_open: bool = false
var disable_control: bool = false

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var inventory_ui = $"../InventoryUI"

var inventory : Inventory = Inventory.new()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if !disable_control:
			head.rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor() and !disable_control:
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Open_inventory"):
		if inventory_open:
			inventory_ui.close_inventory()
			inventory_open = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			disable_control = false
		else:
			inventory_ui.inventory = inventory
			inventory_ui.create_inventory()
			inventory_open = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			disable_control = true
		
	
	# Speed Multiplier Value for later
	var speed = SPEED
	
	
	_apply_movement(speed, delta)
	_raycast_check()
	move_and_slide()
	


	
# Applying movement to the Character
func _apply_movement(speed : float, delta : float):
	var input_dir = Vector3.ZERO
	if !disable_control:
		input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")   # Handle Movement Input
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()   # Make Movement relative to Camera
	if is_on_floor():
		if direction:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 5.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 5.0)
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 10.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 10.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
	
	

func _raycast_check():
	var ray = $Head/Camera3D/RayCast3D
	if (ray.get_collider() != null):
		$MeshInstance3D.global_position = ray.get_collision_point()
		pass
