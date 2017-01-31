extends Node2D

var background_parts = Array()
var portion_scene
var max_part_width
var min_part_width
var current_bot_height = 20
var current_top_height = 20

func _ready():
	portion_scene = preload("res://scenes/BackgroundPortion.tscn")
	var vp_width = get_viewport_rect().size.width
	max_part_width = vp_width * 0.5
	min_part_width = vp_width * 0.2
	fill_background_portions()
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	var first_portion = get_children().front()
	var camera_pos = get_parent().get_node("Camera2D").get_pos().x
	if first_portion != null and first_portion.get_pos().x -  camera_pos < -first_portion.width:
		first_portion.queue_free()
		fill_background_portions()

func fill_background_portions():
	var current_end = 0
	if get_child_count() > 0:
		var last_portion = get_children().back()
		current_end = last_portion.get_pos().x + last_portion.width
	var vp_width = get_viewport_rect().size.width
	var camera_pos = get_parent().get_node("Camera2D").get_pos().x
	while current_end < camera_pos + vp_width + max_part_width:
		var width = rand_range(min_part_width, max_part_width)
		add_new_portion(current_end, width)
		current_end += width

func add_new_portion(start_x, width):
	var portion = portion_scene.instance()
	portion.initialize(width, current_top_height, current_bot_height)
	portion.set_pos(Vector2(start_x, 0))
	add_child(portion)
	current_bot_height = portion.end_bot_height
	current_top_height = portion.end_top_height
