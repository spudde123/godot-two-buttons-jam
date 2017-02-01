extends Sprite

func _ready():
	get_node("AnimationPlayer").play("Explode")
	get_node("AnimationPlayer").connect("finished", self, "animation_finished")
	
func animation_finished():
	queue_free()
	
