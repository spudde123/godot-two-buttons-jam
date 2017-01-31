extends KinematicBody2D

var direction = Vector2(1, 0)
var speed = 300
var explosion_scene

func _ready():
	explosion_scene = preload("res://scenes/Explosion.tscn")
	set_fixed_process(true)
	
func _fixed_process(delta):
	move(direction*delta*speed)
	if is_colliding():
		if get_collider().is_in_group("hittable"):
			get_collider().on_bullet_hit()
		explode()
		queue_free()
		
func initialize(pos, angle):
	set_pos(pos)
	direction = direction.rotated(angle)
	get_node("Sprite").rotate(angle)

func explode():
	var explosion = explosion_scene.instance()
	explosion.set_pos(get_pos())
	get_tree().get_root().add_child(explosion)

func on_bullet_hit():
	queue_free()
