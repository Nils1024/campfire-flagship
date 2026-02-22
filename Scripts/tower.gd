extends Node2D

@onready var children = []

var base_reload_time := 1.3
var can_attack := true

func _process(_delta):
	$Area.scale = Vector2(Shop.towerRadius, Shop.towerRadius)
	if can_attack and children.size() > 0:
		attack()


func attack():
	can_attack = false
	
	remove_children()
	
	
	var final_reload = base_reload_time * Shop.reloadtime
	await get_tree().create_timer(final_reload).timeout
	
	can_attack = true


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
		var health = child.get_meta("HEALTH")
		
		if health <= 1:
			GlobalData.child_count -= 1
			
			var base_points = 1
			var amount = base_points * Shop.multiplier
			@warning_ignore("narrowing_conversion")
			GlobalData.points += amount
			
			children_to_erase.append(child)
			child.queue_free()
		else:
			
			child.set_meta("HEALTH", health - Shop.strenght)
	
	for child in children_to_erase:
		children.erase(child)
