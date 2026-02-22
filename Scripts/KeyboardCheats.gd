extends Node

var keyboard_mode := false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if not keyboard_mode:
		return
	
	if not (event is InputEventKey and event.pressed):
		return
	
	match event.keycode:
		KEY_E: trigger_tower("code1")
		KEY_C: trigger_tower("code2")
		KEY_G: trigger_tower("code3")
		KEY_U: trigger_tower("code4")
		KEY_M: trigger_tower("code5")



func trigger_tower(code_name: String):
	var barcode_script = get_tree().get_first_node_in_group("BarcodeManager")
	if barcode_script:
		var code_data = barcode_script.codes[code_name]
		barcode_script.spawn_effect(code_data["file"])
		barcode_script.remove_effect(code_data["file"])
