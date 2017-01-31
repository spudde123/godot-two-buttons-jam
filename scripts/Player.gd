
extends KinematicBody2D

signal game_over

var move_vec = Vector2(1.5, 0)
const y_accel = 0.1 
const y_max_speed = 5
const max_degree = 80

var bullet_scene
var explosion_scene

func _ready():
	bullet_scene = preload("res://scenes/Bullet.tscn")
	explosion_scene = preload("res://scenes/Explosion.tscn")
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	if Input.is_action_pressed("move_up"):
		#move_vec.y = min(move_vec.y, 0)
		move_vec.y -= y_accel
	else:
		#move_vec.y = max(move_vec.y, 0)
		move_vec.y += y_accel
	move_vec.y = clamp(move_vec.y, -y_max_speed, y_max_speed)
	move(move_vec)
	set_rotd(-move_vec.y / y_max_speed * max_degree)
	if is_colliding():
		game_over()

func _input(event):
	if event.is_action_released("shoot"):
		shoot()

func shoot():
	var bullet = bullet_scene.instance()
	var offset = Vector2(50, 0).rotated(get_rot())
	bullet.initialize(get_pos() + offset, get_rot())
	get_tree().get_root().get_node("2ButtonGame/ShortLived").add_child(bullet)
	
func game_over():
	var explosion = explosion_scene.instance()
	explosion.set_pos(get_pos())
	get_tree().get_root().get_node("2ButtonGame/ShortLived").add_child(explosion)
	emit_signal("game_over")
	queue_free()
	
func on_bullet_hit():
	game_over()
	

