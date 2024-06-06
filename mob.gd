extends RigidBody2D

func _ready() -> void:
	$AnimatedSprite2D.play(get_random_animation())

func _process(_delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func get_random_animation() -> String:
	var animation_types: PackedStringArray = $AnimatedSprite2D.sprite_frames.get_animation_names()
	return animation_types[randi() % animation_types.size()]
