extends Area2D

var troop = null

@export_category("Variables")
@export var collectable_data: Array
@export var help: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if help != null:
		help.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_instance_valid(troop) and Input.is_action_just_pressed("Test"):
		troop.send_item(collectable_data)
		
		if get_parent() is RigidBody2D:
			get_parent().queue_free()
			return
		
		queue_free()


func _on_notifier_screen_entered():
	show()





func _on_body_entered(_body):
	troop = _body
	if help != null:
		help.modulate.a = 1


func _on_body_exited(_body):
	troop = null
	if help != null:
		help.modulate.a = 0
