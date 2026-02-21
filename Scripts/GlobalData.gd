extends Node

var roundnum := 1
var spawn_amount := 5
var child_count := spawn_amount
var reload_time := 1.0
var health := 10.0

# Called when the node enters the scene tree for the first time.
func next_round():
	roundnum += 1
	spawn_amount *= 1.5
	child_count = spawn_amount
