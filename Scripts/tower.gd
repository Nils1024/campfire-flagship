extends Node2D

@onready var children = []
# Called when the node enters the scene tree for the first time

func _process(_delta):
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
	var children_to_erase = []
	for child in children:
		if child.get_meta("HEALTH") <= 1:
			GlobalData.child_count -= 1
			var base_points = 1
			var amount = base_points * Shop.multiplier
			@warning_ignore("narrowing_conversion")
			GlobalData.points += amount
			children_to_erase.append(child)
			child.queue_free()
		else:
			child.set_meta("HEALTH",child.get_meta("HEALTH")-1)
	for child in children:
		if children_to_erase.has(child):
			children.erase(child)
		
