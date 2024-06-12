extends Camera2D

#MADE BY Thiago Avidos "PbmnLuv"
#MIT License

enum CameraMode {
  FIXED,
  FOLLOW,
  FOLLOW_INTERACTIVE,
}

@export var PlayerNode: Player = null
@export var mode: CameraMode = CameraMode.FIXED

@export var followOnJump: bool = false

@export var followSpeed_horizontal: float = 5.0
@export var followSpeed_vertical: float = 4.0
@export var jumpFollowReducer: float = 1.0

@export var lookUpAmount: float = 50.0
@export var lookDownAmount: float = 50.0

# on follow and follow interactive only
@export var enableLookAhead: bool = true
@export var lookAheadDistance: float = 50.0


func _physics_process(delta):
	
	_updateCamera(delta)
	
	pass


func _updateCamera(delta):
	
	if PlayerNode != null:
		
		if mode == CameraMode.FIXED:
			#FIXED CAMERA CODE
			global_position = PlayerNode.global_position
			
			pass
			
		elif mode == CameraMode.FOLLOW:
			#BASIC CUSTOMIZABLE FOLLOW CODE
			var dif = PlayerNode.global_position - global_position
			if dif.length() > 1:
				
				if PlayerNode.velocity.y > -PlayerNode.initial_jump_speed:
					global_position.x += dif.x*delta*followSpeed_horizontal
					global_position.y += dif.y*delta*followSpeed_vertical
				else:
					global_position.x += dif.x*delta*followSpeed_horizontal
					if followOnJump or PlayerNode.is_on_floor():
						global_position.y += dif.y*delta*followSpeed_vertical/jumpFollowReducer
		elif mode == CameraMode.FOLLOW_INTERACTIVE:
			# A FEATURE RICH FOLLOW CODE, includes looking up and down, and fluid jumping follow (if enabled)
			var target_pos = PlayerNode.global_position
			
			
			
			if PlayerNode.is_on_floor() and (Input.is_action_pressed("Up") or Input.is_action_pressed("UpJoy")):
				target_pos = PlayerNode.global_position + Vector2(0.0, -lookUpAmount)
			elif PlayerNode.is_on_floor() and (Input.is_action_pressed("Down") or Input.is_action_pressed("DownJoy")):
				target_pos = PlayerNode.global_position + Vector2(0.0, lookDownAmount)
			
			if enableLookAhead:
				if Input.is_action_pressed("Right") or Input.is_action_pressed("RightJoy"):
					target_pos.x += lookAheadDistance
					pass
				elif Input.is_action_pressed("Left") or Input.is_action_pressed("LeftJoy"):
					target_pos.x -= lookAheadDistance
					
			var dif = target_pos - global_position
			if dif.length() > 1:
				
				if PlayerNode.velocity.y > 0 and global_position.y < PlayerNode.global_position.y:#-PlayerNode.initial_jump_speed*1.5 :
					global_position.x += dif.x*delta*followSpeed_horizontal
					global_position.y += dif.y*delta*followSpeed_vertical
				else:
					global_position.x += dif.x*delta*followSpeed_horizontal
					
					if PlayerNode.is_on_floor() and  ((Input.is_action_pressed("Up") or Input.is_action_pressed("Down") or Input.is_action_pressed("DownJoy") or Input.is_action_pressed("UpJoy") ) or PlayerNode.global_position.length() == target_pos.length()):
						global_position.y += dif.y*delta*followSpeed_vertical
						pass
					else:
						if followOnJump:
							global_position.y += dif.y*delta*followSpeed_vertical/jumpFollowReducer
				
			
			
			pass
			
		
		pass
	
	pass
