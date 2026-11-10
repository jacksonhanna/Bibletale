extends CharacterBody2D

var image_path: String = "res://icon.svg"

const SPEED: int = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	var direction: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0,0)
	
	move_and_slide()
