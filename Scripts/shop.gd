extends Control
func update_prices():
	$Dim/Buttons/FasterReload.text = "Faster Reload ($%d)" % Shop.powerups["FasterReload"]["price"]
	$Dim/Buttons/IncreaseRadius.text = "Increase Radius ($%d)" % Shop.powerups["BiggerRadius"]["price"]
	$Dim/Buttons/IncreaseDamage.text = "Increase Damage ($%d)" % Shop.powerups["MorePower"]["price"]
	$"Dim/Buttons/2xPoints".text = "2x Points ($%d)" % Shop.powerups["2xPoints"]["price"]

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	update_prices()
func _process(_delta):
	update_prices()
	$Dim/Title2.text = "Current Amount of Points:" + str(GlobalData.points)
func _on_Celsius_pressed():
	Shop.select_tower("TowerOne")
	update_prices()

func _on_Cheezits_pressed():
	Shop.select_tower("TowerTwo")
	update_prices()

func _on_Numpad_pressed():
	Shop.select_tower("TowerFour")
	update_prices()

func _on_Coke_pressed():
	Shop.select_tower("TowerFive")
	update_prices()


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
	update_prices()


func _on_close_pressed():
	get_tree().paused = false
	queue_free()
