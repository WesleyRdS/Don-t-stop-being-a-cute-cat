extends CharacterBody2D
class_name Enemy

@export_category("Variable")
@export var _move_speed: float = 100.0
@export var _acceleration: int = 7
@export var _name: String = ""


@export_category("Objects")
@export var _monitoring_area: Area2D
@export var _wait_timer: Timer
@export var _animation: AnimationPlayer
@export var path_follow: PathFollow2D
@export var _navigation_agent: NavigationAgent2D
var _in_effect = false
var _permission_to_move = true
var _can_patrol = true
var initial_position: Vector2

func _ready():
	_can_patrol = false
	_monitoring_area.monitoring = false
	_in_effect = true
	_permission_to_move = false
	_wait_timer.start(5)
	initial_position = self.global_position

	if _name == "son":
		global._son = self
	elif _name == "mother":
		global._mother = self
	elif _name == "father":
		global._father = self
	elif _name == "daughter":
		global._daughter = self
	elif _name == "dog":
		global._dog = self
	else:
		pass

func _physics_process(_delta: float) -> void:
	if global.player == null:
		return	
	if global.player._active_efect():
		if velocity.y < 0 or (velocity.x !=0 and velocity.y < 0):
			if global.player != null:
				_animation.play("FrontConfuse")
		elif velocity.y > 0 or (velocity.x !=0 and velocity.y > 0):
			if global.player != null:
				_animation.play("BackConfuse")
		_stun()
	
	if _can_patrol: 
		if path_follow.progress < 0:
			if global.player != null:
				_animation.play("BackRunN")
		if path_follow.progress > 0:
			if global.player != null:
				_animation.play("FrontRunN")
		

	
	if _permission_to_move and not _in_effect:
		if global._object_falling:
			var _direction = _navigation_agent.get_next_path_position() - global_position
			_direction = _direction.normalized()
			makepath()
			velocity = velocity.lerp(_direction * _move_speed, _acceleration * _delta)
			if velocity.y < 0 or (velocity.x !=0 and velocity.y < 0):
				if global.player != null:
					_animation.play("FrontRunR")
			elif velocity.y > 0 or (velocity.x !=0 and velocity.y > 0):
				if global.player != null:
					_animation.play("BackRunN")
			move_and_slide()
		else:
			path_follow.progress += _move_speed * _delta
			if path_follow.progress < 0:
				if global.player != null:
					_animation.play("BackRunN")
			if path_follow.progress > 0:
				if global.player != null:
					_animation.play("FrontRunN")
		

			
	
		
		
func makepath() -> void:
	_navigation_agent.target_position = global.player.global_position


func _stun() -> void:
	if global.player._animation.current_animation == "hability1" and global.player._on_range:
		_can_patrol = false
		_in_effect = true
		global._object_falling = false
		_monitoring_area.monitoring = false
		_permission_to_move = false
		_wait_timer.start(5)
		global._construct_enemy(self)
	if global.player._animation.current_animation == "hability2" and global.player._on_range:
		_can_patrol = false
		_in_effect = true
		global._object_falling = false
		_monitoring_area.monitoring = false
		_permission_to_move = false
		_wait_timer.start(10)
	if global.player._animation.current_animation == "hability3" and global.player._on_range:
		_can_patrol = false
		_in_effect = true
		global._object_falling = false
		_monitoring_area.monitoring = false
		_permission_to_move = false
		_wait_timer.start(15)

func _on_wait_timer_timeout() -> void:
	_can_patrol = true
	_monitoring_area.monitoring = true
	_in_effect = false
	_permission_to_move = true

	

func _on_monitoring_area_body_entered(_body) -> void:
	_permission_to_move = false
	if global.player._active_efect() == false:
		global._object_falling = false
		global.tentativas += 1
		get_tree().change_scene_to_file("res://Management/Scene/game_over.tscn")
	else:
		set_deferred("monitoring",false)

		


func _on_monitoring_area_body_exited(_body) -> void:
	_permission_to_move = true
