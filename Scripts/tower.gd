extends Node2D

@onready var children = get_meta("children")
# Called when the node enters the scene tree for the first time.

func _ready():
	print("START")

func _on_area_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy.is_in_group("Enemy"):
		children.append(enemy)


func _on_area_area_exited(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy.is_in_group("Enemy"):
		children.erase(enemy)
