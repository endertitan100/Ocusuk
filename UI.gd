extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("openInv"):
		var Enabled = not get_tree().paused
		get_tree().paused = Enabled
		get_node("Inventory").visible = Enabled
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
