extends Area2D

@export var Conversation: PackedScene

@export var convo_path: String
@export var image_path: String
var player_image_path: String
var approachable: bool = false

func _ready() -> void:
	$Label.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and approachable:
		var convo = Conversation.instantiate()
		convo.convo_path = convo_path
		convo.icon1 = player_image_path
		convo.icon2 = image_path
		get_tree().root.add_child(convo)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		approachable = true
		player_image_path = body.image_path
		$Label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		approachable = false
		$Label.hide()
