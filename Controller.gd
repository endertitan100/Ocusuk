extends MeshInstance2D


var Velocity = Vector2(0,0)
var LastTime = 0.0
var NoiseGen = FastNoiseLite.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("jump") and Time.get_ticks_msec() - LastTime > 207:
		Velocity.y = -1.2
		LastTime = Time.get_ticks_msec()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Diving = false
	if Input.is_action_pressed("left"): Velocity.x -= 20*delta
	if Input.is_action_pressed("right"): Velocity.x += 20*delta
	if Input.is_action_pressed("dive"):
		Velocity.y += 20*delta
		Diving = true
	
	var Power = NoiseGen.get_noise_1d(Time.get_ticks_msec()/60.0)
	Power += 1.3
	Power *= 0.8
	Velocity.x *= 0.95
	Velocity.x -= Power*delta
	if Velocity.x > 2.2: Velocity.x = 2.2
	Velocity.y += 1.4*delta
	
	#Add slower falling speed than diving speed
	if Diving and (Velocity.y > 2.2):
		Velocity.y = 2.2
	elif not Diving and (Velocity.y > 1.2):
		Velocity.y = 1.2
	
	position += Velocity
	
	if position.x < -610 or position.x > 610:
		position.x = clamp(position.x,-610,610)
	if position.y < -350 or position.y > 350:
		position.y = clamp(position.y,-350,350)
