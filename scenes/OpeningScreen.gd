extends CanvasLayer

func _ready():
	set_process_input(true)
	
func _input(event):
	if event.is_action_released("move_up") or event.is_action_released("shoot"):
		get_tree().change_scene("res://scenes/2ButtonGame.tscn")