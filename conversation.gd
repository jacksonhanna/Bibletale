extends Control

var convo_path: String
var icon1: String
var icon2: String
var line_index: int
var max_lines: int
var lines: Variant

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("conversation started")
	line_index = 0
	$ColorRect/TextureRect.texture = ImageTexture.create_from_image(Image.load_from_file(icon1))
	$ColorRect/TextureRect2.texture = ImageTexture.create_from_image(Image.load_from_file(icon2))
	$ColorRect/TextureRect.hide()
	$ColorRect/TextureRect2.hide()
	var file: FileAccess = FileAccess.open(convo_path, FileAccess.READ)
	
	if file == null:
		push_error("Failed to open dialogue file")
		
	var text: String = file.get_as_text()
	
	file.close()
	
	var json: JSON = JSON.new()
	var error: Error = json.parse(text)
	
	if error != OK:
		push_error("Failed to parse JSON: ", json.get_error_message())
		
	lines = json.data
	max_lines = lines.size()
	
	get_tree().paused = true
	
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("select"):
		line_index += 1
		
	if line_index == max_lines:
		get_tree().paused = false
		queue_free()
	else:
		$ColorRect/Label.text = lines[line_index]["line"]
		
		if lines[line_index]["speaker"] == 1:
			$ColorRect/TextureRect.show()
			$ColorRect/TextureRect2.hide()
		else:
			$ColorRect/TextureRect2.show()
			$ColorRect/TextureRect.hide()
