class_name Player
extends CharacterBody2D
#MADE BY Thiago Avidos "PbmnLuv"
#MIT License


#control the run movimentation
@export var run_acceleration: float = 400.0
@export var max_run_speed: float = 300.0
@export var break_speed: float = 2000.0

#control the gravity and jump impulse
@export var gravity: float = 300.0
@export var initial_jump_speed: float = -100.0

#control whether the player can jump higher by holding the jump button
@export var holdToJumpHigher: bool = true
@export var holdJumpIntensity: float = 1.4

#control how many jumps the player can execute
@export var max_jumps: int = 1
@onready var currentJumps: int = 1


enum CoyoteTimeMode {
  NONE,
  INFINITE,
  LIMITED_TIME,
}
@export var coyoteTimeMode: CoyoteTimeMode = CoyoteTimeMode.NONE # 0 == no coyote time / 1 == infinite coyote time / 2 == limited coyote time
@export var coyoteTime_time_limit: float = 1000.0 # in miliseconds
@onready var coyoteTimer = 0



	
func _physics_process(delta):
		
	updatePlayer(delta)
	
	pass
	
func updatePlayer(delta):
	
	_moveUpdate(delta)
	
	pass

#this takes care of all the basic player inputs for jumping and moving
func _moveUpdate(delta):
	
	_updateGravity(delta)
	
	if Input.is_action_pressed("Right") or Input.is_action_pressed("RightJoy"):
		if velocity.x < 0.0:
			velocity.x = 0.0
		velocity.x += delta*run_acceleration
		if velocity.x >= max_run_speed:
			velocity.x = max_run_speed
		
		pass
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("LeftJoy"):
		if velocity.x > 0.0:
			velocity.x = 0.0
		velocity.x -= delta*run_acceleration
		if velocity.x <= -max_run_speed:
			velocity.x = -max_run_speed
		pass
	else:
		if velocity.x > 0.1:
			velocity.x -= delta*break_speed
			if velocity.x <= 0.1:
				velocity.x = 0.0
		elif velocity.x < -0.1:
			velocity.x += delta*break_speed
			if velocity.x >= -0.1:
				velocity.x = 0.0
	
	if coyoteTimeMode == CoyoteTimeMode.LIMITED_TIME:
		if is_on_floor():
			coyoteTimer = 0.0
		else:
			if coyoteTimer <= coyoteTime_time_limit:
				coyoteTimer += delta*1000 #timer in milisseconds
	
	if Input.is_action_just_pressed("Accept") and currentJumps > 0:
		
		if coyoteTimeMode == CoyoteTimeMode.NONE:
			_jump()
			pass
		elif coyoteTimeMode == CoyoteTimeMode.INFINITE:
			_jump()
		elif coyoteTimeMode == CoyoteTimeMode.LIMITED_TIME:
			if coyoteTimer <= coyoteTime_time_limit or currentJumps > 0:
				_jump()
			pass
		
		pass
	
	
	
	move_and_slide()
	
	pass

func _updateGravity(delta):	
	if is_on_floor() == false:
		if holdToJumpHigher and Input.is_action_pressed("Accept"):
			velocity.y += gravity/holdJumpIntensity * delta
		else:
			velocity.y += gravity * delta
		pass
	else:
		currentJumps = max_jumps
	
	pass

func _jump():
	currentJumps -= 1
	velocity.y = initial_jump_speed
	pass



