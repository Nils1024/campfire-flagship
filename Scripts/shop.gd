extends Control


func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _on_Celsius_pressed():
	Shop.select_tower("TowerOne")

func _on_Cheezits_pressed():
	Shop.select_tower("TowerTwo")

func _on_Numpad_pressed():
	Shop.select_tower("TowerFour")

func _on_Coke_pressed():
	Shop.select_tower("TowerFive")


func _on_faster_reload_pressed():
	Shop.select_powerup("FasterReload")


func _on_increase_radius_pressed():
	Shop.select_powerup("BiggerRadius")


func _on_increase_damage_pressed():
	Shop.select_powerup("MorePower")


func _on_x_points_pressed():
	Shop.select_powerup("2xPoints")


func _on_Yubikey_pressed():
	Shop.select_tower("TowerThree")


func _on_close_pressed():
	get_tree().paused = false
	queue_free()
