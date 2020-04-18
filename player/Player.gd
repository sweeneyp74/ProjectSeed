extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity = -9.8
export var movementSpeed = 250
export var rotationSpeed = 10

var dead = false

func _ready():
	pass

func _update_grounded():
	# Make sure we have the latest raycast data
	$GroundChecker.force_raycast_update()
	# Update the is_grounded variable
	return $GroundChecker.is_colliding()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var isGrounded = _update_grounded()
	
	var grav = 0
	
	if(!isGrounded):
		grav = gravity
		print("falling!")
	
		
	var moveVector = Vector3(0,grav,0)
	
	if Input.is_action_pressed("ui_up"):
		moveVector.z -= 1
	if Input.is_action_pressed("ui_down"):
		moveVector.z += 1
	if Input.is_action_pressed("ui_left"):
		moveVector.x -= 1
	if Input.is_action_pressed("ui_right"):
		moveVector.x += 1
		
	if Input.is_key_pressed(KEY_H):
		dead = true
		print("dead")
		
	var finalMovement = moveVector.normalized() * movementSpeed * delta
	
	handleAnimation(delta, moveVector)
	
	if(!dead):
		move_and_slide(finalMovement)


func handleAnimation(delta, movementDirection):
	var ad = $CollisionShape/Hero2.get_transform().basis.z
	var vecta = Vector2(movementDirection.z,-movementDirection.x)
	var vectb = Vector2(ad.x, ad.y)
	
	
	var rotation = vecta.dot(vectb) * delta * rotationSpeed
	print(rotation)
	if(movementDirection.length() > 0 && (rotation == 0 || rotation == -0)):
		rotation = 0.1
		print("special")
	
	if(!dead):
		var animationSpeed = clamp(movementDirection.length(),0,1)
		$CollisionShape/Hero2.rotate_z(rotation)
		$CollisionShape/Hero2/AnimationTree.set("parameters/alive/blend_position", animationSpeed)

			
	else:
		$CollisionShape/Hero2/AnimationTree.set("parameters/conditions/isDead", true)
		
