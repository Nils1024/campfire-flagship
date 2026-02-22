extends Node

var keyboard_mode := false
var can_fire := true

# 1.0 = same speed
# 1.5 = 50% slower
# 2.0 = twice as slow
var keyboard_penalty := .8


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func _input(event):
	if not keyboard_mode:
		return
	
	if not can_fire:
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
	if not barcode_script:
		return
	
	var code_data = barcode_script.codes[code_name]

	can_fire = false

	barcode_script.spawn_effect(code_data["file"])
	barcode_script.remove_effect(code_data["file"])


	var delay = Shop.reloadtime * keyboard_penalty
	
	await get_tree().create_timer(delay).timeout
	
	can_fire = true
