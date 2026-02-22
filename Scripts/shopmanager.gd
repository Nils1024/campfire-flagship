extends Node

var barcode_buffer: String = ""
var multiplier :float = 1.0
var reloadtime : float = 1.0
var towerRadius : float = 1.0
var strenght : float = 1.0 


enum barcodeState {
	WAITING_FOR_TOWER,
	WAITING_FOR_POWERUP
}

var current_state = barcodeState.WAITING_FOR_POWERUP
var pending_powerup: String = ""

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		if keycode == KEY_ENTER or keycode == KEY_KP_ENTER:
			if barcode_buffer != "":
				on_barcode_scanned(barcode_buffer)
				barcode_buffer = ""
		else:
			var ch = char(event.unicode)
			if event.unicode > 0:
				barcode_buffer += ch

func on_barcode_scanned(barcode: String) -> void:
	match current_state:
		barcodeState.WAITING_FOR_POWERUP:
			if is_valid_powerup(barcode):
				pending_powerup = barcode
				current_state = barcodeState.WAITING_FOR_TOWER

		barcodeState.WAITING_FOR_TOWER:
			if is_valid_tower(barcode):
				apply_powerup_to_tower(pending_powerup, barcode)
				reset_scan_state()
			else:
				print("Invalid tower barcode.")

func is_valid_powerup(barcode: String) -> bool:
	
	match barcode:
		"FasterReload", "BiggerRadius", "MorePower", "2xPoints":
			return true
	return false


func is_valid_tower(barcode: String) -> bool:
	match barcode:
		"TowerOne", "TowerTwo", "TowerThree", "TowerFour", "TowerFive":
			return true
	return false

var fastreloadprice := 5
var biggerradiusprice := 5
var morepowerprice := 5
var twoxpointsprice := 15

func apply_powerup_to_tower(powerup: String, tower: String) -> void:
	print("Applying ", powerup, " to ", tower)
	
	match powerup:
		"FasterReload":
			if GlobalData.points >= fastreloadprice:
				GlobalData.points -= fastreloadprice
				fastreloadprice *= 2
				reloadtime = max(0.1, reloadtime - 0.1)
				
		"BiggerRadius":
			if GlobalData.points >= biggerradiusprice:
				GlobalData.points -= biggerradiusprice
				biggerradiusprice *= 2
				towerRadius += 0.5
				
		"MorePower":
			if GlobalData.points >= morepowerprice:
				GlobalData.points -= morepowerprice
				morepowerprice *= 2
				strenght += 1
				
		"2xPoints":
			if GlobalData.points >= twoxpointsprice:
				GlobalData.points -= twoxpointsprice
				twoxpointsprice *= 2
				multiplier *= 2


func reset_scan_state():
	pending_powerup = ""
	current_state = barcodeState.WAITING_FOR_POWERUP
