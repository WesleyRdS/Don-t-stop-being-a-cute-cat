extends Node
class_name Global


var player: Player = null
var _object_falling: bool = false
var _on_inventory: bool = false
var gamelevel: Node2D = null
var n_itensDrop: int = 0
var item_craft: Array = []
var is_visible: bool = false #inventory
var _son: CharacterBody2D = null
var _mother: CharacterBody2D = null
var _father: CharacterBody2D = null
var _daughter: CharacterBody2D = null
var _dog: CharacterBody2D = null
var _generate_enemy: bool = false
var _fase: int = 1
var enemy_: PackedScene = preload("res://Enemies/Scenes/father.tscn")
var enemyf_: PackedScene = preload("res://Enemies/Scenes/girl.tscn")
var tentativas: int = 0

	

func _construct_enemy(char: CharacterBody2D):
	char._animation.play("FrontConfuse")
	if char.name == "Boy":
		var enemy: CharacterBody2D = enemy_.instantiate()
		enemy.scale.x = 0.1
		enemy.scale.y = 0.1
		char.path_follow.add_child(enemy)
		enemy.path_follow = char.path_follow
		enemy._name = char._name
		char.queue_free()
	if char.name == "Girl":
		var enemy: CharacterBody2D = enemyf_.instantiate()
		enemy.scale.x = 0.1
		enemy.scale.y = 0.1
		char.path_follow.add_child(enemy)
		enemy.path_follow = char.path_follow
		enemy._name = char._name
		char.queue_free()
	
