extends Node
@export var code1 : String = "889392021394"
var code2: String = "992-00014-SIF"

var barcode_buffer: String = ""
#effect,explosion,actual effect
signal areaBodyEntered

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		if keycode == KEY_ENTER or keycode == KEY_KP_ENTER:
			if barcode_buffer != "":
				on_barcode_scanned(barcode_buffer)
				barcode_buffer = ""
		else:
			# Append the character to the buffer
			var ch = char(event.unicode)
			if event.unicode > 0:
				barcode_buffer += ch

func on_barcode_scanned(barcode: String) -> void:
	if barcode == code1:
		spawn_effect($"test-folder/Tower")
	elif barcode == code2:
		spawn_effect($"test-folder/Tower2")
	
	$Label.text = barcode
	print("Scanned barcode: ", barcode)
	
	# Do whatever you want with the barcode here
	
func spawn_effect(effect):
	var color_rect = effect.get_node("ColorRect")
	var original_color = color_rect.color
	color_rect.color = "Black"
	await get_tree().create_timer(.2).timeout #await animation end insteadd
	color_rect.color = original_color
