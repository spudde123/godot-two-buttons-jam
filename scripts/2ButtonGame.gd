extends Node2D

var current_score = 0
var game_over_timer = 0
var game_over = false
var game_over_delay = 1
var camera_pos = Vector2()
const camera_offset = -100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("JetpackPlayer").connect("game_over", self, "handle_game_over")
	change_labels()
	set_process(true)
	camera_pos.y = 0
	
func _process(delta):
	if has_node("JetpackPlayer"):
		camera_pos.x = get_node("JetpackPlayer").get_pos().x + camera_offset
		get_node("Camera2D").set_pos(camera_pos)
	if game_over:
		game_over_timer += delta
	else:
		current_score += delta
		get_node("ScoreLayer/CurrentScore").set_text("Current score: %.02f" % current_score)
	if game_over_timer > game_over_delay:
		restart_game()

func restart_game():
	get_tree().change_scene("res://scenes/2ButtonGame.tscn")
	
func handle_game_over():
	var global_node = get_node("/root/global")
	if current_score > global_node.high_score:
		global_node.high_score = current_score
	current_score = 0
	game_over = true
	change_labels()
	
func change_labels():
	var high = get_node("ScoreLayer/HighScore")
	var cur = get_node("ScoreLayer/CurrentScore")
	high.set_text("Best score: %.02f" % get_node("/root/global").high_score)
	cur.set_text("Current score: %.02f" % current_score)
