extends KinematicBody2D


export (int) var speed = 64

var velocity = Vector2()

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer
onready var hit_sound = $HitSound


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		sprite.flip_h = false
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		sprite.flip_h = true
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if velocity != Vector2():
		anim_player.play("move")
	else:
		anim_player.play("RESET")
