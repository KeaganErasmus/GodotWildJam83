extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var move_sound := $MoveSound

var max_hunger_amount: int = 200
var min_hunger_amount: int = 0
var hunger_amount: int = max_hunger_amount

var is_dead: bool = false

var click_position: Vector2
var release_position: Vector2

var max_move_speed: int = 200
var move_amount: Vector2
var drag_amount: float = 0.02

var max_scale = Vector2(.5,.5)
var min_scale = Vector2.ZERO
var player_scale : Vector2 = max_scale
var distance_traveled: int = 0
var distance_per_hunger_loss: int = 100

var open_hand = load("res://assets/hand_small_open.png")
var closed_hand = load("res://assets/hand_small_closed.png")

var pref_pos: Vector2
var dist: float

func _ready():
	animation.play("idle")
	Input.set_custom_mouse_cursor(open_hand)
	scale = player_scale

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			Input.set_custom_mouse_cursor(closed_hand)
			click_position = get_viewport().get_mouse_position()
		if event.button_index == 1 and event.is_released():
			Input.set_custom_mouse_cursor(open_hand)
			release_position = get_viewport().get_mouse_position()
			move_amount = click_position - release_position
			velocity = move_amount
			move_sound.play()


func _physics_process(delta: float) -> void:
	pref_pos = position
	if !is_dead:
		velocity.x = clamp(velocity.x, -max_move_speed, max_move_speed)
		velocity.y = clamp(velocity.y, -max_move_speed, max_move_speed)

		velocity.x = lerpf(velocity.x, 0, drag_amount)
		velocity.y = lerpf(velocity.y, 0, drag_amount)

		move_and_slide()


func _process(delta: float) -> void:
	if hunger_amount <= 0:
		is_dead = true

	if !is_dead:
		dist = position.distance_to(pref_pos)
		distance_traveled += dist
		if distance_traveled >= distance_per_hunger_loss:
			lose_hunger(10)
			shrink()
			distance_traveled = 0

func consume(amount: int) -> void:
	hunger_amount += amount
	grow()
	if scale > max_scale:
		scale = max_scale

func lose_hunger(amount: int) -> void:
	hunger_amount -= amount
	print(hunger_amount)

func shrink() -> void:
	scale -= Vector2(.01,.01)

func grow() -> void:
	scale += Vector2(.1, .1)
