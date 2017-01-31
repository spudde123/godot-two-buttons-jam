extends StaticBody2D

const rot_speed = 0.5

func _ready():
	set_process(true)

func _process(delta):
	get_node("Sprite").rotate(rot_speed*delta)
func on_bullet_hit():
	queue_free()
