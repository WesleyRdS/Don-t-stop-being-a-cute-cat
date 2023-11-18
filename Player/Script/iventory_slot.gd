extends TextureRect
class_name InventorySlot

@export_category("Objects")
@export var _amount_text: Label
@export var _item_texture: TextureRect
@onready var blender: PackedScene = preload("res://Items/Scene/blender.tscn")
@onready var board: PackedScene = preload("res://Items/Scene/board.tscn")
@onready var box: PackedScene = preload("res://Items/Scene/box.tscn")
@onready var bucket: PackedScene = preload("res://Items/Scene/bucket.tscn")
@onready var glue: PackedScene = preload("res://Items/Scene/glue.tscn")
@onready var laptop: PackedScene = preload("res://Items/Scene/laptop.tscn")
@onready var remote: PackedScene = preload("res://Items/Scene/remote.tscn")
@onready var screw: PackedScene = preload("res://Items/Scene/screw.tscn")
@onready var spring: PackedScene = preload("res://Items/Scene/spring.tscn")
@onready var tape: PackedScene = preload("res://Items/Scene/tape.tscn")
@onready var toilet: PackedScene = preload("res://Items/Scene/toilet.tscn")
@onready var tools: PackedScene = preload("res://Items/Scene/tools.tscn")
@onready var collectable: PackedScene = preload("res://Items/Scene/collectibles.tscn")
enum list{
	AMOUNT,
	IMAGE_PATH,
	ADDITIONAL_INFO,
	SELL_PRICE,
	TYPE,
	NAME
}

var item_info: Array
var can_click: bool = false

func  _ready():
	_amount_text.hide()

func set_item(item: Array) -> void:
	var  item_image_path: String = item[list.IMAGE_PATH]
	_item_texture.texture = load(item_image_path)
	_amount_text.text = str(item[list.AMOUNT])

	
	item_info = item
	
func update_amount(new_amount: int) -> void:
	_amount_text.text = str(new_amount)
	
func _on_mouse_entered() -> void:
	if global.is_visible:
		can_click = true
		_item_texture.modulate.a = 0.5


func _on_mouse_exited() -> void:
	if global.is_visible:
		can_click = false
		_item_texture.modulate.a = 1.0
	
func _process(_delta: float) -> void:
	if global._on_inventory:
		_amount_text.show()
	else:
		_amount_text.hide()
	if can_click and Input.is_action_just_pressed("clickLeft"):
		verify_item()
		
func verify_item():
	var object: Area2D = null
	if item_info[list.NAME] == "Blender":
		item_info[list.AMOUNT] -= 1
		object = blender.instantiate()
		object.scale.x = 0.2
		object.scale.y = 0.2
	elif item_info[list.NAME] == "Board":
		item_info[list.AMOUNT] -= 1
		object = board.instantiate()
		object.scale.x = 0.4
		object.scale.y = 0.4
	elif item_info[list.NAME] == "Box":
		item_info[list.AMOUNT] -= 1
		object = box.instantiate()
		object.scale.x = 0.2
		object.scale.y = 0.2
	elif item_info[list.NAME] == "Bucket":
		item_info[list.AMOUNT] -= 1
		object = bucket.instantiate()
		object.scale.x = 0.2
		object.scale.y = 0.2
	elif item_info[list.NAME] == "Glue":
		item_info[list.AMOUNT] -= 1
		object = glue.instantiate()
		object.scale.x = 0.05
		object.scale.y = 0.05
	elif item_info[list.NAME] == "Laptop":
		item_info[list.AMOUNT] -= 1
		object = laptop.instantiate()
	elif item_info[list.NAME] == "Remote":
		item_info[list.AMOUNT] -= 1
		object = remote.instantiate()
		object.scale.x = 0.1
		object.scale.y = 0.1
	elif item_info[list.NAME] == "Screw":
		item_info[list.AMOUNT] -= 1
		object = screw.instantiate()
		object.scale.x = 0.05
		object.scale.y = 0.05
	elif item_info[list.NAME] == "Spring":
		item_info[list.AMOUNT] -= 1
		object = spring.instantiate()
		object.scale.x = 0.05
		object.scale.y = 0.05
	elif item_info[list.NAME] == "Tape":
		item_info[list.AMOUNT] -= 1
		object = tape.instantiate()
		object.scale.x = 0.05
		object.scale.y = 0.05
	elif item_info[list.NAME] == "Toilet":
		item_info[list.AMOUNT] -= 1
		object = toilet.instantiate()
		object.scale.x = 0.2
		object.scale.y = 0.2
	elif item_info[list.NAME] == "Tools":
		item_info[list.AMOUNT] -= 1
		object = tools.instantiate()
		object.scale.x = 0.1
		object.scale.y = 0.1
	else:
		item_info[list.AMOUNT] -= 1
		object = collectable.instantiate()
		object.scale.x = 0.2
		object.scale.y = 0.2
	global.gamelevel.add_child(object)
	object.global_position = global.player.global_position
	global.item_craft.append(item_info[list.NAME]) 
			
	if item_info[list.AMOUNT] == 0:
		global.player._inventory.delete_slot(get_index())
		return
	global.player._inventory.update_slot(get_index(),item_info[list.AMOUNT])
