extends CharacterBody2D

@export var speed = 300.0
@export var jump_force = 400.0

@onready var animation: AnimationPlayer = $animation
@onready var sprite = $sprites

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float
var atacando: bool
const numero_Collision = 37

func _process(delta):
	animate()
	mover()
	fliph()
	


func fliph():
	if velocity.x > 0:
		$sprites.flip_h = false
		$AttackArea/Collision.position.x = numero_Collision
	if velocity.x < 0:
		$sprites.flip_h =  true
		$AttackArea/Collision.position.x = -numero_Collision


func animate(): 
	if atacando:
		animation.play("attack")
		return
	if velocity.y > 0 and not is_on_floor():
		animation.play("fall")
		return
	if velocity.y < 0 and not is_on_floor():
		animation.play("jump")
		return
	if velocity.x != 0:
		animation.play("run")
		return
	if velocity.x == 0:
		animation.play("idle")
		return
		


func _physics_process(delta):
	gravidade(delta)
	mover()
	


func _input(event: InputEvent):
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
	if Input.is_action_just_pressed("attack"):
		ataque()
	direction = Input.get_axis("ui_left", "ui_right")


func mover():
	velocity.x = direction * speed
	move_and_slide()


func gravidade(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
		

func jump():
	velocity.y = -jump_force


func ataque():
	atacando = true
	




func _on_animation_finished(anim_name):
	if anim_name == "attack":
		atacando = false
