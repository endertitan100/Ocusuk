extends Node2D

var Random = RandomNumberGenerator.new()
var LastSpawn:int = 0
var BaseEnemy = preload("res://enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Time.get_ticks_msec() - LastSpawn > Random.randi_range(2400,6000):
		LastSpawn = Time.get_ticks_msec()
		
		var enemy_instance = BaseEnemy.instantiate()
		get_parent().add_child(enemy_instance)

# Make some ability to collect and pickup scales
