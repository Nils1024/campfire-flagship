extends Node

var barcode_buffer: String = ""

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


func apply_powerup_to_tower(powerup: String, tower: String) -> void:
	print("Applying ", powerup, " to ", tower)
	
	match powerup:
		"FasterReload":
			pass
		"BiggerRadius":
			pass
		"MorePower":
			pass
		"2xPoints":
			pass


func reset_scan_state():
	pending_powerup = ""
	current_state = barcodeState.WAITING_FOR_POWERUP
