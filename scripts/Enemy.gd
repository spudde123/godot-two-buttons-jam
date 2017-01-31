extends StaticBody2D

const firing_interval = 2
var since_last_fired = 0
signal enemy_down
var bullet_scene = preload("res://scenes/Bullet.tscn")
const min_angle = -90
const max_angle = 0
var rot_speed = 0.5
var since_last_dir_change = 0
var dir_change_interval = 2
const max_dir_change_interval = 3

func _ready():
	set_process(true)
	
func _process(delta):
	since_last_fired += delta
	if since_last_fired >= firing_interval:
		try_to_shoot()
	var cannon = get_node("Cannon")
	if since_last_dir_change < dir_change_interval:
		since_last_dir_change += delta
	else:
		since_last_dir_change = 0
		rot_speed *= -1
		dir_change_interval = rand_range(0.2*max_dir_change_interval, max_dir_change_interval)
	cannon.rotate(rot_speed*delta)
	cannon.set_rotd(clamp(cannon.get_rotd(), -90, 0))
	
func on_bullet_hit():
	emit_signal("enemy_down")
	queue_free()

func try_to_shoot():
	var bullet = bullet_scene.instance()
	var offset = Vector2(70, 0)
	var cannon_rot = PI + get_node("Cannon").get_rot()
	bullet.initialize(get_global_pos() + offset.rotated(cannon_rot), cannon_rot)
	get_tree().get_root().get_node("2ButtonGame/ShortLived").add_child(bullet)
	since_last_fired = 0
