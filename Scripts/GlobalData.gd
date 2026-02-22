extends Node

var roundnum 
var spawn_amount: int
var child_count: int
var health : int

var points : int
var mutation_chance: int
var mutations = ["SPEED","HEALTH"]
var max_scale: float
var min_scale: float
var scale_increase: float

func _ready():
	reset_variables()
# Called when the node enters the scene tree for the first time.
func next_round():
	roundnum += 1
	if roundnum%3 == 0:
		max_scale += scale_increase
	@warning_ignore("narrowing_conversion")
	spawn_amount *= 1.5
	child_count = spawn_amount
	mutation_chance += 6

func reset_variables():
	mutation_chance = 4
	scale_increase = .25
	max_scale = 1.0
	min_scale = max_scale + scale_increase
	roundnum = 1
	spawn_amount = 5
	child_count = spawn_amount
	health = 10
	points = 0
	
