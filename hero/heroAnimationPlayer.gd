extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_animation("Armature|Run").set_loop(true)
	get_animation("Armature|Walk").set_loop(true)
	get_animation("Armature|Idle").set_loop(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
