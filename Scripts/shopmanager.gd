extends Node

var barcode_buffer := ""

var multiplier: float = 1.0
var reloadtime: float = 1.0
var towerRadius: float = 1.0
var strenght: float = 1.0

enum BarcodeState {
	WAITING_FOR_POWERUP,
	WAITING_FOR_TOWER
}

var current_state = BarcodeState.WAITING_FOR_POWERUP
var pending_powerup := ""

var powerups = {
	"FasterReload": {
		"price": 5,
		"apply": func(): reloadtime = max(0.1, reloadtime - 0.1)
	},
	"BiggerRadius": {
		"price": 5,
		"apply": func(): towerRadius += 0.5
	},
	"MorePower": {
		"price": 5,
		"apply": func(): strenght += 1
	},
	"2xPoints": {
		"price": 15,
		"apply": func(): multiplier *= 2
	}
}

var valid_towers = [
	"TowerOne",
	"TowerTwo",
	"TowerThree",
	"TowerFour",
	"TowerFive"
]


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
			if barcode_buffer.strip_edges() != "":
				on_barcode_scanned(barcode_buffer.strip_edges())
				barcode_buffer = ""
		elif event.unicode > 31 and event.unicode < 127:
			barcode_buffer += char(event.unicode)


func on_barcode_scanned(barcode: String) -> void:
	match current_state:
		BarcodeState.WAITING_FOR_POWERUP:
			if powerups.has(barcode):
				pending_powerup = barcode
				current_state = BarcodeState.WAITING_FOR_TOWER
				print("Scan a tower.")
		
		BarcodeState.WAITING_FOR_TOWER:
			if barcode in valid_towers:
				apply_powerup(pending_powerup)
				reset_scan_state()
			else:
				print("Invalid tower barcode.")


func apply_powerup(powerup: String):
	var data = powerups[powerup]
	var price = data["price"]

	if GlobalData.points >= price:
		GlobalData.points -= price
		
		data["apply"].call()
		
		data["price"] *= 2
		
		print(powerup, " upgraded.")
	else:
		print("Not enough points.")


func reset_scan_state():
	pending_powerup = ""
	current_state = BarcodeState.WAITING_FOR_POWERUP
