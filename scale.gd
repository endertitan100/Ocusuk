extends Sprite2D

var Random = RandomNumberGenerator.new()
var Velocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	var R = Random.randi_range(0,255)
	var G = Random.randi_range(0,255)
	var B = Random.randi_range(0,255)
	modulate = Color8(R,G,B)
	Velocity.y = Random.randi_range(-1,0.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.y += 1.2 * delta
	if Velocity.y > 0.9: Velocity.y = 0.9
	
	position += Velocity
	
	if position.y > 400:
		queue_free()
