extends Node2D

var spawn_queue = []
@onready var tower_scene = preload("res://tower.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add()

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
	print
