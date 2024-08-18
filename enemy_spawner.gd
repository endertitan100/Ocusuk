extends Node2D

var LastSpawn:int = 0
var BaseEnemy = preload("res://enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Time.get_ticks_msec() - LastSpawn > 1000:
		LastSpawn = Time.get_ticks_msec()
		
		var enemy_instance = BaseEnemy.instantiate()
		get_parent().add_child(enemy_instance)

# Write code to clone enemy and damage player with a growinh hitbox 
# Make some code that displays health and ability to collect and pickup scales
