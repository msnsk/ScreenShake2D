extends Camera2D

enum {
	ROUGH,
	SMOOTH
}

# Common Properties
var type = ROUGH
var trauma = 0.0
var trauma_power = 2
var amount = 0.0

# Rough Shake Properties
var decay = 0.8
var max_offset = Vector2(36, 64)
var max_roll = 0.1

# Smooth Shake Properties
var noise_y = 0
onready var noise = OpenSimplexNoise.new()


func _ready():
	randomize()
	
	# for Smooth Shake
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2


func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		if type == ROUGH:
			rough_shake()
		elif type == SMOOTH:
			smooth_shake()


func rough_shake():
	amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)


func smooth_shake():
	amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)


func set_shake(add_trauma = 0.5):
	trauma = min(trauma + add_trauma, 1.0)


func _unhandled_input(event):
	if event.is_action_pressed("shake"):
		set_shake()
	if event.is_action_pressed("ui_right")\
	or event.is_action_pressed("ui_left"):
		if type == ROUGH:
			type = SMOOTH
		else:
			type = ROUGH
