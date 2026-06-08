extends CharacterBody2D

const SPEED : float = 500.0

@export var paddle_0 : Node2D
@export var paddle_1 : Node2D

func _ready() -> void:
	initialize()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func initialize():
	var extra_offset = 0.0 if randf() < 0.5 else PI
	var angle = extra_offset + randf_range(-PI/3.0, PI/3.0 )
	velocity = Vector2(cos(angle), sin(angle)).normalized() * SPEED
	position = get_viewport_rect().size / 2.0

func _on_screen_exited() -> void:
	await get_tree().create_timer(1.0).timeout
	var vw = get_viewport_rect().size[0]
	var ball_x = position[0]
	if ball_x < 0:
		paddle_1.increment_score()
	else:
		paddle_0.increment_score()
	initialize()
