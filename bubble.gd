extends MeshInstance2D

var Velocity = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	Velocity.x = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.x *= 0.8
	Velocity.y -= 1.2*delta
	
	position += Velocity
	
	if position.y < -360:
		queue_free()
