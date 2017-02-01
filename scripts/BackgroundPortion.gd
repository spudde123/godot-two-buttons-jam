extends Node2D

var portions = Array()
var max_part_height
var width
const min_height = 20
var end_bot_height = min_height
var end_top_height = min_height
var st_bot_height = 0
var st_top_height = 0
var enemy_scene = preload("res://scenes/Enemy.tscn")
var texture = preload("res://images/redrubble.png")
var destructible_env = preload("res://scenes/DestructibleEnvironment.tscn")
const tint_color = Color(0.7, 0.7, 0.7)
var max_top_height = min_height
var max_bot_height = min_height
var destructible_allowed = true

func _ready():
	max_part_height = get_viewport_rect().size.height * 0.4
	create_top_part(width)
	create_bot_part(width)
	if destructible_allowed:
		create_destructible_part(width)
	
func initialize(w, start_top_height, start_bot_height, destructible):
	width = w
	st_top_height = start_top_height
	st_bot_height = start_bot_height
	destructible_allowed = destructible
	
func create_physics_body(polygon):
	var convex_polygon = ConvexPolygonShape2D.new()
	convex_polygon.set_points(polygon.get_polygon())
	var body = StaticBody2D.new()
	body.add_shape(convex_polygon)
	add_child(body)

func create_top_part(part_width):
	var vp_height = get_viewport_rect().size.height
	var w1 = rand_range(0, part_width * 0.4)
	var w2 = part_width - w1
	var start_height = st_top_height
	max_top_height = rand_range(start_height, max_part_height)
	var end_height = rand_range(min_height, max_top_height)
	var width_top = rand_range(0.1*w2, 0.9*w2)
	
	var pol1 = Polygon2D.new()
	var p1 = Vector2Array()
	p1.append(Vector2(0, 0))
	p1.append(Vector2(w1, 0))
	p1.append(Vector2(w1, start_height))
	p1.append(Vector2(0, start_height))
	pol1.set_polygon(p1)
	pol1.set_texture(texture)
	pol1.set_color(tint_color)
	
	var pol2 = Polygon2D.new()
	var p2 = Vector2Array()
	p2.append(Vector2(w1, 0))
	p2.append(Vector2(w1+w2, 0))
	p2.append(Vector2(w1+w2, end_height))
	p2.append(Vector2(w1+(w2-width_top)*0.5+width_top, max_top_height))
	p2.append(Vector2(w1+(w2-width_top)*0.5, max_top_height))
	p2.append(Vector2(w1, start_height))
	pol2.set_polygon(p2)
	pol2.set_texture(texture)
	pol2.set_color(tint_color)
	
	end_top_height = end_height
	add_child(pol1)
	add_child(pol2)
	create_physics_body(pol1)
	create_physics_body(pol2)
	
func create_bot_part(part_width):
	var vp_height = get_viewport_rect().size.height
	var w1 = rand_range(0, part_width * 0.4)
	var w2 = part_width - w1
	var start_height = st_bot_height
	max_bot_height = rand_range(start_height, max_part_height)
	var end_height = rand_range(min_height, max_bot_height)
	var width_top = rand_range(0.3*w2, 0.9*w2)
	var w3 = part_width - w2 - w1
	
	var pol1 = Polygon2D.new()
	var p1 = Vector2Array()
	p1.append(Vector2(0, vp_height - start_height))
	p1.append(Vector2(w1, vp_height - start_height))
	p1.append(Vector2(w1, vp_height))
	p1.append(Vector2(0, vp_height))
	pol1.set_polygon(p1)
	pol1.set_texture(texture)
	pol1.set_color(tint_color)
	
	var pol2 = Polygon2D.new()
	var p2 = Vector2Array()
	p2.append(Vector2(w1, vp_height - start_height))
	p2.append(Vector2(w1+(w2-width_top)*0.5, vp_height - max_bot_height))
	p2.append(Vector2(w1+(w2-width_top)*0.5+width_top, vp_height - max_bot_height))
	p2.append(Vector2(w1+w2, vp_height - end_height))
	p2.append(Vector2(w1+w2, vp_height))
	p2.append(Vector2(w1, vp_height))
	pol2.set_polygon(p2)
	pol2.set_texture(texture)
	pol2.set_color(tint_color)
	
	if randf() < 0.8:
		var new_enemy = enemy_scene.instance()
		new_enemy.set_pos(Vector2(w1+w2*0.5, vp_height - max_bot_height - 10))
		add_child(new_enemy)
	
	end_bot_height = end_height
	add_child(pol1)
	add_child(pol2)
	create_physics_body(pol1)
	create_physics_body(pol2)
		
func create_destructible_part(part_width):
	if randf() < 0.6:
		var dest = destructible_env.instance()
		var vp_height = get_viewport_rect().size.height
		dest.set_pos(Vector2(rand_range(0.1*part_width, 0.9*part_width), rand_range(max_top_height, vp_height - max_bot_height)))
		add_child(dest)
