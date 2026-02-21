extends Node
var code1 : String = "889392021394"
var code2: String = "992-00014-SIF"

var barcode_buffer: String = ""

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = event.keycode
		
		# Enter key = barcode scan complete
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
		$"test-folder/1".color = "Black"
	elif barcode == code2:
		
		$"test-folder/2".color = "Black"
	
	$Label.text = barcode
	print("Scanned barcode: ", barcode)
	# Do whatever you want with the barcode here
