extends Node2D

@export_category("Variables")
@export var _item_1: String
@export var _item_2: String
@export var _item_3: String
@export var _anim: AnimationPlayer
@export var button: Sprite2D
var can_process_item = false

# Called when the node enters the scene tree for the first time.
func _ready():
	button.modulate.a = 0
	_anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_objective_itens()
	if can_process_item:
		can_process_item = false
		global.item_craft = []
		get_tree().change_scene_to_file("res://Management/Scene/win.tscn")


func _objective_itens():
	if global._fase == 1:
		$Objectives/Animation.play("fase1")
	else:
		pass

func _on_collect_area_area_entered(area):
	area.queue_free()
	for i in range (0,global.item_craft.size()):
		if global.item_craft[i] == _item_1 or global.item_craft[i] ==_item_2 or global.item_craft[i] ==_item_3:
			if global.item_craft[i] == _item_1:
				_item_1 == ""
			elif global.item_craft[i] == _item_2:
				_item_2 == ""
			elif global.item_craft[i] == _item_3:
				_item_3 == ""
			else:
				pass
			global.item_craft.remove_at(i)
			global.n_itensDrop += 1
			
			
	if global.n_itensDrop == 3:
		can_process_item = true


func _on_body_body_entered(_body):
	_anim.play("play")
	button.modulate.a = 1


func _on_body_body_exited(_body):
	_anim.play("idle")
	button.modulate.a = 0
