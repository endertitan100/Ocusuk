extends MeshInstance2D

var Random = RandomNumberGenerator.new()
var Speed = Random.randf_range(50,75)
# Called when the node enters the scene tree for the first time.
func _ready():
	var height = Random.randi_range(-300,300)
	position = Vector2(700,height)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= Vector2(Speed,0) * delta
	if position.x < -700: queue_free()
