extends MeshInstance2D

var Random = RandomNumberGenerator.new()
var Speed = Random.randf_range(50,90)
var LastAttack = 0
var YVel = 0
var Height = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Height = Random.randi_range(-250,300)
	position = Vector2(700,Height)
	LastAttack = Time.get_ticks_msec()

func Attack():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.5,1.5), 0.5).set_trans(Tween.TRANS_BACK)
	await get_tree().create_timer(1).timeout
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1,1), 0.5).set_trans(Tween.TRANS_BACK)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Basic Movement
	position -= Vector2(Speed,0) * delta
	if position.x < -700: queue_free()
	if position.y > Height:
		YVel = -0.9
		#BS that makes enemies bounce
		if Random.randi() % 3 == 0:
			Height += Random.randi_range(-100,100)
		else:
			Height += Random.randi_range(-40,40)
		if Height > 300: Height = Random.randi_range(200,280)
		if Height < -250: Height = Random.randi_range(-150,-230)
		
	YVel += 1.4*delta
	if YVel > 0.7: YVel = 0.7
	
	position.y += YVel
	
	if Time.get_ticks_msec()-LastAttack > Random.randi_range(4800,10000):
		LastAttack = Time.get_ticks_msec()
		Speed = Random.randf_range(45,90)
		Attack()
