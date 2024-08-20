extends Node2D

var Random = RandomNumberGenerator.new()
var LastSpawn:int = 0
var BaseEnemy = preload("res://enemy.tscn")
@export var SpawnTime:int
@export var SpawnRange:int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var Min = SpawnTime * 1000
	var Max = Min + SpawnRange * 1000
	if Time.get_ticks_msec() - LastSpawn > Random.randi_range(Min,Max):
		LastSpawn = Time.get_ticks_msec()
		
		var enemy_instance = BaseEnemy.instantiate()
		get_parent().add_child(enemy_instance)

# Make some ability to collect and pickup scales
