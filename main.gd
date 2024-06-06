extends Node

@export var mob_scene: PackedScene
var score

func _ready() -> void:
	new_game()

func _process(_delta: float) -> void:
	pass
	
func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var spawn_location = $MobPath/MobSpawnLocation
	spawn_location.progress_ratio = randf()
	var direction = spawn_location.rotation + PI / 2
	mob.position = spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += 1

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
