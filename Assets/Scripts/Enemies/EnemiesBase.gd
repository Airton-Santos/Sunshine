extends CharacterBody2D


const SPEED = 300.0
@export var direction := -10
@onready var animation_enemies: AnimationPlayer = $AnimationEnemies
@onready var ray: RayCast2D = $Ray
@onready var sprite_enemies: Sprite2D = $SpriteEnemies



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if ray.is_colliding():
		direction *= -1
		ray.scale.x *= -1
		flip()
	
	if direction:
		velocity.x = direction * SPEED * delta
		animation_enemies.play("run")

	move_and_slide()
	
func flip():
	if velocity.x > 0:
		sprite_enemies.flip_h = true
	if velocity.x <0:
		sprite_enemies.flip_h = false
