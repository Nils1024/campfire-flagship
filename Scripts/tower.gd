extends Node2D

@onready var children = []
# Called when the node enters the scene tree for the first time

func _process(delta):
	$Area.scale = Vector2(Shop.towerRadius, Shop.towerRadius)

func _on_area_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy.is_in_group("Enemy"):
		children.append(enemy)


func _on_area_area_exited(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy.is_in_group("Enemy"):
		
		children.erase(enemy)

func remove_children():
	for child in children:
		GlobalData.child_count -= 1
		var base_points = 1
		var amount = base_points * Shop.multiplier
		@warning_ignore("narrowing_conversion")
		GlobalData.points += amount
		child.queue_free()
	children.clear()
		
