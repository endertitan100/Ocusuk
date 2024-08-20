extends MeshInstance2D

@export var WaveSurgePower:float
@export var MoveSpeed:float = 20
@export var FloatStrength:float = 1.2
@onready var HealthBar: ProgressBar = $Health

var Velocity = Vector2(0,0)
var LastJump = 0.0
var LastDamaged = 0.0
var LastShoot = 0.0
var NoiseGen = FastNoiseLite.new()
var Health = 100
var ShouldDamage = false
var DamageArea:Area2D
var BaseBubble = preload("res://bubble.tscn")

func HandleMovement(delta):
	var Diving = false
	if Input.is_action_pressed("left"): Velocity.x -= MoveSpeed*delta
	if Input.is_action_pressed("right"): Velocity.x += MoveSpeed*delta
	if Input.is_action_pressed("dive"):
		Velocity.y += MoveSpeed*delta
		Diving = true
	
	var Power = NoiseGen.get_noise_1d(Time.get_ticks_msec()/60.0) 
	Power += 1.1
	Power *= 0.8 * WaveSurgePower
	
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
	
	#Add borders
	if position.x < -610 or position.x > 610:
		position.x = clamp(position.x,-610,610)
	if position.y < -350 or position.y > 350:
		position.y = clamp(position.y,-350,350)

func DamagePlayer():
	if not ShouldDamage: return
	var Type = DamageArea.name
	if (Type == "Floor" or Type == "Enemy") and Time.get_ticks_msec() - LastDamaged > 377:
		LastDamaged = Time.get_ticks_msec()
		if  Type == "Floor":
			Health -= 5
		elif Type == "Enemy":
			Health -= 10
		HealthBar.value = Health
		if Health <= 0:
			get_tree().change_scene_to_file("res://Game.tscn")

func ShootBubble():
	var bubble_instance = BaseBubble.instantiate()
	get_parent().add_child(bubble_instance)
	bubble_instance.position = position

func _input(event):
	if event.is_action_pressed("jump") and Time.get_ticks_msec() - LastJump > 207:
		Velocity.y = -1 * FloatStrength
		LastJump = Time.get_ticks_msec()
	elif event.is_action_pressed("shoot") and Time.get_ticks_msec() - LastShoot > 346:
		LastShoot = Time.get_ticks_msec()
		ShootBubble()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	HandleMovement(delta)
	DamagePlayer()

func _on_area_2d_area_entered(area:Area2D):
	DamageArea = area
	ShouldDamage = true

func _on_area_2d_area_exited(area):
	var Type = area.name
	if not DamageArea: return
	if Type == DamageArea.name:
		ShouldDamage = false
		DamageArea = null
