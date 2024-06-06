extends Area2D

@export var speed: int = 400
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO
	velocity = handle_movement_input(velocity)
	velocity = animate_player(velocity)
	update_position(velocity, delta)
	handle_animations(velocity)

func handle_movement_input(velocity: Vector2) -> Vector2:
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	return velocity
	
func animate_player(velocity: Vector2) -> Vector2:
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	return velocity

func update_position(velocity: Vector2, delta) -> void:
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func handle_animations(velocity: Vector2) -> void:
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
