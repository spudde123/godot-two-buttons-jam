extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("AnimationPlayer").play("Explode")
	get_node("AnimationPlayer").connect("finished", self, "animation_finished")
	
func animation_finished():
	queue_free()
	
