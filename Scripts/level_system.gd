extends Node2D

var spawn_queue = []
@onready var tower_scene = preload("res://enemy.tscn")
var children = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_level()

func next_level():
	for i in range(GlobalData.spawn_amount):	
		add()
		await get_tree().create_timer(.5).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalData.child_count <= 0:
		GlobalData.next_round()
		next_level()
	if not spawn_queue.is_empty():
		var enemy: PathFollow2D = spawn_queue.pop_front()
		var animation_player: AnimationPlayer = enemy.get_child(2)
		$Path2D.add_child(enemy)
		animation_player.play("Walk")
		var mutation_select = randi_range(1,100)
		if mutation_select <= GlobalData.mutation_chance:
			var mutation = GlobalData.mutations.pick_random()
			match mutation:
				"SPEED":
					animation_player.speed_scale *= 2
				"HEALTH":
					var scale = [GlobalData.min_scale,GlobalData.max_scale].pick_random()
					enemy.scale *= scale
					set_meta("HEALTH", 1+(scale-1)/GlobalData.scale_increase)
		else:
			enemy.set_meta("Mutation","None")
			enemy.set_meta("HEALTH", 1)
		children.append(enemy)

func add():
	var new_tower = tower_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	new_tower.add_to_group("Enemy")
	spawn_queue.append(new_tower)

func return_health(child):
	if children.has(child):
		return true
