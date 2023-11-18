extends CharacterBody2D
class_name Player

@export_category("Variable")
@export var _move_speed: float = 100.0
@export var _jump_velocity: float = -300

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _cute_area: Area2D
@export var _hability_timer: Timer
@export var _inventory: Node
@export var _player: CharacterBody2D
@export var _skill_animation: AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _permmision_to_use = true
var _on_range = false
var cont: int
var anim_finhised = false


func _ready() -> void:
	global.player = self
	cont = 0
	
func _physics_process(_delta: float) ->void:
	$Camera/Fixed/Control/Left.modulate = "ffffff86"
	$Camera/Fixed/Control/Right.modulate = "ffffff86"
	$Camera/Fixed/Control/Down.modulate = "ffffff86"
	$Camera/Fixed/Control/Space.modulate = "ffffff86"
	if global._object_falling:
		$Texture/_animationA.play("WarningPlay")
	else:
		$Texture/_animationA.play("WarningIdle")
	_moviment(_delta)
	_hability()

func gravity_hability(_delta:float) -> void:
	if anim_finhised == false:
		if Input.is_action_just_pressed("Gforce"):
			if _permmision_to_use:
				_permmision_to_use = false
				_hability_timer.start(5)
				if cont < 3:
					cont += 1
				else:
					cont = 0
				
				if cont == 0:
					_skill_animation.play("cooldown_1")
				elif cont == 1:
					_skill_animation.play("cooldown_2")
				elif cont == 2:
					_skill_animation.play("cooldown_3")
				else:
					_skill_animation.play("cooldown_4")
				
		if cont == 0:
			_player.set_deferred("rotation", 0.0)
			if not is_on_floor():
				velocity.y += _gravity * _delta

			if Input.is_action_just_pressed("Jump") and is_on_floor():
				_animation.play("Jump")
				velocity.y = _jump_velocity * _move_speed/150
				$Camera/Fixed/Control/Space.modulate.a = 63
			elif velocity.x != 0 and (is_on_floor() or is_on_ceiling() or is_on_wall()):
				_animation.play("Run")
			elif is_on_floor() or is_on_ceiling() or is_on_wall():
				_animation.play("Idle")
			else:
				_animation.play("Jump")
				$Camera/Fixed/Control/Space.modulate.a = 63
				
			var _direction = Input.get_axis("Left", "Right")
			if _direction:
				velocity.x = _direction * _move_speed
			else:
				velocity.x = move_toward(velocity.x, 0, _move_speed)
			
			if _direction < 0:
				$Texture.scale.x = -1
				$Collision.scale.x = -1
				$Camera/Fixed/Control/Left.modulate = "ffffffff"
			if _direction > 0:
				$Texture.scale.x = 1
				$Collision.scale.x = 1
				$Camera/Fixed/Control/Right.modulate = "ffffffff"

				
		
				
		elif cont == 1:
			_player.set_deferred("rotation", -1.5708)
			if not is_on_floor():
				velocity.x += _gravity * _delta
			if Input.is_action_just_pressed("Jump") and is_on_wall():
				$Camera/Fixed/Control/Space.modulate = "ffffffff"
				_animation.play("Jump")
				velocity.x = _jump_velocity * _move_speed/150
			elif velocity.y != 0 and (is_on_floor() or is_on_ceiling() or is_on_wall()):
				_animation.play("Run")
			elif is_on_floor() or is_on_ceiling() or is_on_wall():
				_animation.play("Idle")
			else:
				_animation.play("Jump")
				$Camera/Fixed/Control/Space.modulate = "ffffffff"
				
			var _direction = Input.get_axis("Left", "Right")
			if _direction:
				velocity.y = _direction * _move_speed
				
			else:
				velocity.y = move_toward(velocity.y, 0, _move_speed)
			
			if _direction < 0:
				$Texture.scale.x = 1
				$Collision.scale.x = 1
				$Camera/Fixed/Control/Left.modulate = "ffffffff"
			if _direction > 0:
				$Texture.scale.x = -1
				$Collision.scale.x = -1
				$Camera/Fixed/Control/Right.modulate = "ffffffff"

				
		
				
		elif cont == 2:
			_player.set_deferred("rotation", -3.14159)
			if not is_on_floor():
				velocity.y -= _gravity * _delta

			if Input.is_action_just_pressed("Jump") and is_on_ceiling():
				_animation.play("Jump")
				$Camera/Fixed/Control/Space.modulate = "ffffffff"
				velocity.y = -_jump_velocity * _move_speed/150
			elif velocity.x != 0 and (is_on_floor() or is_on_ceiling() or is_on_wall()):
				_animation.play("Run")
			elif is_on_floor() or is_on_ceiling() or is_on_wall():
				_animation.play("Idle")
			else:
				_animation.play("Jump")
				$Camera/Fixed/Control/Space.modulate = "ffffffff"
				
			var _direction = Input.get_axis("Left", "Right")
			if _direction:
				velocity.x = _direction * _move_speed
			else:
				velocity.x = move_toward(velocity.x, 0, _move_speed)
			
			if _direction < 0:
				$Texture.scale.x = 1
				$Collision.scale.x = 1
				$Camera/Fixed/Control/Left.modulate = "ffffffff"
			if _direction > 0:
				$Texture.scale.x = -1
				$Collision.scale.x = -1
				$Camera/Fixed/Control/Right.modulate = "ffffffff"

				
			
				
		elif cont == 3:
			_player.set_deferred("rotation", -4.71239)
			if not is_on_floor():
				velocity.x -= _gravity * _delta
			if Input.is_action_just_pressed("Jump") and is_on_wall():
				_animation.play("Jump")
				$Camera/Fixed/Control/Space.modulate = "ffffffff"
				velocity.x = -_jump_velocity * _move_speed/150
			elif velocity.y != 0 and (is_on_floor() or is_on_ceiling() or is_on_wall()):
				_animation.play("Run")
			elif is_on_floor() or is_on_ceiling() or is_on_wall():
				_animation.play("Idle")
			else:
				_animation.play("Jump")
				$Camera/Fixed/Control/Space.modulate = "ffffffff"
				
			var _direction = Input.get_axis("Left", "Right")
			if _direction:
				velocity.y = _direction * _move_speed
				
			else:
				velocity.y = move_toward(velocity.y, 0, _move_speed)
			
			if _direction < 0:
				$Texture.scale.x = -1
				$Collision.scale.x = -1
				$Foot/Collision.scale.x = -1
				$Camera/Fixed/Control/Left.modulate = "ffffffff"
			if _direction > 0:
				$Texture.scale.x = 1
				$Collision.scale.x = 1
				$Foot/Collision.scale.x = 1
				$Camera/Fixed/Control/Right.modulate = "ffffffff"
		
		
func _moviment(_delta: float) -> void:
	
	gravity_hability(_delta)
	if Input.is_action_pressed("Lower") and (is_on_floor() or is_on_ceiling() or is_on_wall()):
		_animation.play("lower")
		$Camera/Fixed/Control/Down.modulate.a = 63
		if cont == 0 or cont == 2:
			velocity.x = 0
		if cont == 1 or cont == 3:
			velocity.y = 0
		

	

	move_and_slide()
	
func _hability() -> void:
	if _permmision_to_use:
		if Input.is_action_pressed("Hability1"):
			_permmision_to_use = false
			_hability_timer.start(5)
			anim_finhised = true
			_animation.play("hability1")
			if cont == 0:
				_skill_animation.play("cooldown_1")
			elif cont == 1:
				_skill_animation.play("cooldown_2")
			elif cont == 2:
				_skill_animation.play("cooldown_3")
			else:
				_skill_animation.play("cooldown_4")
			await(_animation.animation_finished)
			if _on_range == true:
				global._object_falling = false
		if Input.is_action_pressed("Hability2"):
			_permmision_to_use = false
			_hability_timer.start(10)
			anim_finhised = true
			_animation.play("hability2")
			if cont == 0:
				_skill_animation.play("cooldown_1")
			elif cont == 1:
				_skill_animation.play("cooldown_2")
			elif cont == 2:
				_skill_animation.play("cooldown_3")
			else:
				_skill_animation.play("cooldown_4")
			await(_animation.animation_finished)
			if _on_range == true:
				global._object_falling = false
		if Input.is_action_pressed("Hability3"):
			_permmision_to_use = false
			_hability_timer.start(15)
			anim_finhised = true
			_animation.play("hability3")
			if cont == 0:
				_skill_animation.play("cooldown_1")
			elif cont == 1:
				_skill_animation.play("cooldown_2")
			elif cont == 2:
				_skill_animation.play("cooldown_3")
			else:
				_skill_animation.play("cooldown_4")
			await(_animation.animation_finished)
			if _on_range == true:
				global._object_falling = false
			

func _active_efect() -> bool:
	return _cute_area.monitorable

func _on_ability_timer_timeout():
	_permmision_to_use = true
	if cont == 0:
		_skill_animation.play("idle_1")
	elif cont == 1:
		_skill_animation.play("idle_2")
	elif cont == 2:
		_skill_animation.play("idle_3")
	else:
		_skill_animation.play("idle_4")


func _on_cute_area_body_entered(_body) -> void:
	_on_range = true


func _on_cute_area_body_exited(_body) -> void:
	_on_range = false


func send_item(item: Array) -> void:
	_inventory.send_item(item)



func _on_animation_animation_finished(anim_name):
	anim_finhised = false
