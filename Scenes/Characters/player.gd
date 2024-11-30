extends CharacterBody2D

# physics 
var speed : int = 150 
var jumpForce : int = 300 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var grounded: bool = false 
var jumpCount: int = 0
@onready var gotHurt: bool = false

@onready var sprite = $Sprite2D
@onready var animationTree = $AnimationTree


func _physics_process(delta):
	velocity.x = 0; 

	if Input.is_action_pressed("right"): 
		velocity.x += speed
	if Input.is_action_pressed("left"): 
		velocity.x -= speed 

	animationTree.set("parameters/Movement/blend_amount",velocity.x)
	velocity.y += gravity * delta
	move_and_slide()

	if is_on_floor():
		jumpCount = 0
		animationTree.set("parameters/JumpAction/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT)

	if Input.is_action_just_pressed("jump") && jumpCount < 1: 
		velocity.y -= jumpForce
		jumpCount += 1
		
	if velocity.y != 0:
		animationTree.set("parameters/JumpAction/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

	# sprite direction 
	if velocity.x < 0: 
		sprite.flip_h = true 

	elif velocity.x > 0:
		sprite.flip_h = false
		
