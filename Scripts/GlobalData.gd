extends Node

var roundnum := 1
var spawn_amount := 5
var child_count := spawn_amount
var health :int= 10 

var points := 0

# Called when the node enters the scene tree for the first time.
func next_round():
	roundnum += 1
	@warning_ignore("narrowing_conversion")
	spawn_amount *= 1.5
	child_count = spawn_amount
