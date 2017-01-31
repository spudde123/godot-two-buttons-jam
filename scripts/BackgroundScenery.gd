extends CanvasLayer

var speed = -60
var x_limit = -800
var scale

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	scale = get_children().front().get_scale().x
	x_limit *= scale
	set_process(true)

func _process(delta):
	#for sprite in get_children():
	#	sprite.translate(Vector2(speed*delta, 0))
	#	if sprite.get_pos().x < x_limit:
	#		sprite.set_pos(Vector2(1900, 300))
	pass