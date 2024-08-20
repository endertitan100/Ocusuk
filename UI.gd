extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Info").text = "A&D to swim side to side"
	await get_tree().create_timer(5).timeout
	get_node("Info").text = "S to dive downwards"
	await get_tree().create_timer(3).timeout
	get_node("Info").text = "W to bob upwards"
	await get_tree().create_timer(3).timeout
	get_node("Info").text = "Click to Shoot"
	await get_tree().create_timer(3).timeout
	get_node("Info").text = "E or I to open inventory"
	await get_tree().create_timer(3).timeout
	get_node("Info").queue_free()

func _input(event):
	if event.is_action_pressed("openInv"):
		var Enabled = not get_tree().paused
		get_tree().paused = Enabled
		get_node("Inventory").visible = Enabled
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
