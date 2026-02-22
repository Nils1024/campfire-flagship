extends Node

var roundnum 
var spawn_amount 
var child_count 
var health : int

var points

func _ready():
	reset_variables()
# Called when the node enters the scene tree for the first time.
func next_round():
	roundnum += 1
	@warning_ignore("narrowing_conversion")
	spawn_amount *= 1.5
	child_count = spawn_amount

func reset_variables():
	roundnum = 1
	spawn_amount = 5
	child_count = spawn_amount
	health = 10
	points = 0
	
