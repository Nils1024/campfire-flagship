extends Node

var roundnum 
var spawn_amount: int
var child_count: int
var health : int
var points
var mutation_chance: int
var mutations = ["SPEED","HEALTH"]

func _ready():
	reset_variables()
# Called when the node enters the scene tree for the first time.
func next_round():
	roundnum += 1
	@warning_ignore("narrowing_conversion")
	spawn_amount *= 1.5
	child_count = spawn_amount
	mutation_chance += 5

func reset_variables():
	mutation_chance = 0
	roundnum = 1
	spawn_amount = 5
	child_count = spawn_amount
	health = 10
	points = 0
	
