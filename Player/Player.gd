extends KinematicBody2D

const WALK_SPEED = 150
const MAX_WALK_SPEED = 600
const STOP_FORCE = 2000
const JUMP_POWER = -600
const LOW_JUMP = 100



var velocity = Vector2()
var jump_released = false

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	#var walk = WALK_SPEED * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	if Input.is_action_pressed("ui_right"):
		velocity.x += WALK_SPEED
		$Sprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x +=- WALK_SPEED
		$Sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x,0,STOP_FORCE*delta)
	velocity.x = clamp(velocity.x,-MAX_WALK_SPEED,MAX_WALK_SPEED)
	
	
	if Input.is_action_just_released("jump"):
		jump_released = true
	
	velocity = move_and_slide_with_snap(velocity,Vector2.DOWN, Vector2.UP)
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_POWER
			jump_released = false
				
	else:
		velocity.y += gravity*delta
	
	if velocity.y>0:
		velocity += Vector2.DOWN * gravity * delta
		
	elif velocity.y<0 && jump_released:
		velocity.y = gravity*delta*6
	
	



func _on_Area2D_body_entered(body):
	if velocity.y >0:
		velocity.y = 0
		
		velocity.y = -1100
	else:
		velocity.y = -1100
