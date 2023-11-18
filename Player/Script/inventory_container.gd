extends TextureRect
class_name InventoryContainer

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _inventory: GridContainer
@export var slot_scene: PackedScene = preload("res://Player/Scene/iventory_slot.tscn")


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("inventory") and not _animation.is_playing():
		play_animation()

func _reset_click_mode() -> void:
	for slot in _inventory.get_children():
		slot.can_click = false
		slot._item_texture.modulate.a = 1.0

func  play_animation() -> void:
	global.is_visible = not global.is_visible
	
	if global.is_visible:
		_animation.play("show")
		for slot in _inventory.get_children():
			slot._item_texture.modulate.a = 1.0
		global._on_inventory = true
		return
	
	_reset_click_mode()
	_animation.play("hide")
	for slot in _inventory.get_children():
			slot._item_texture.modulate.a = 0.0
	global._on_inventory = false

func _update_item_slot(item_index: int, new_amount: int) -> void:
	_inventory.get_child(item_index).update_amount(new_amount)
	
func _create_item_slot(item_info: Array) -> void:
	var slot = slot_scene.instantiate()
	_inventory.add_child(slot)
	slot.set_item(item_info)
	slot._item_texture.modulate.a = 0.0
	
func _delete_inventory_slot(inventory_slot: int) -> void:
	_inventory.get_child(inventory_slot).queue_free()
	
