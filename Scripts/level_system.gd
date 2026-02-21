extends Node2D

var spawn_queue = []
@onready var tower_scene = preload("res://enemy.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in range(Pause.roundnum * 5):	
		add()
		await get_tree().create_timer(.5).timeout
	Pause.roundnum += 1
	await get_tree().create_timer(1).timeout
	next_level()

func next_level():
	
	for i in range(Pause.roundnum * 5):	
		add()
		await get_tree().create_timer(.5).timeout
	Pause.roundnum += 1
	await get_tree().create_timer(1).timeout
	next_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not spawn_queue.is_empty():
		var enemy: PathFollow2D = spawn_queue.pop_front()
		var animation_player: AnimationPlayer = enemy.get_child(2)
		$Path2D.add_child(enemy)
		animation_player.play("Walk")

func add():
	var new_tower = tower_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	new_tower.add_to_group("Enemy")
	spawn_queue.append(new_tower)
