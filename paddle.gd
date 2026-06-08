extends CharacterBody2D

const SPEED: float = 500.0
const DAMPING: float = 0.7
const AI_MARGIN: float = 20.0

@export var player_id: int
@export var score_label: Label
@export var ball: Node2D
var score: int = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('up-%d' % player_id):
		velocity = Vector2(0, -SPEED)
	if event.is_action_pressed('down-%d' % player_id):
		velocity = Vector2(0, SPEED)

	if event.is_action_released('up-%d' % player_id) or \
		event.is_action_released('down-%d' % player_id):
			velocity = Vector2.ZERO
		
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _process(delta: float) -> void:
	if player_id == 1:
		var change = Vector2(0, SPEED*(-1 if position.y > ball.position.y else 1)) * DAMPING
		var middle = get_viewport_rect().size.x / 2.0
		if ball.position.x > middle and (ball.position.y - AI_MARGIN > position.y or position.y > ball.position.y + AI_MARGIN):
			position += change * delta

func increment_score():
	score += 1
	score_label.text = str(score)
