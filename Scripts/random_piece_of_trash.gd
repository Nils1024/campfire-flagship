extends Sprite2D

@export var texture1: Texture2D
@export var texture2: Texture2D
@export var texture3: Texture2D

func _ready():
	randomize()
	
	var textures = [texture1, texture2, texture3]
	texture = textures.pick_random()
