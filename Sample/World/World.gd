extends Node2D

var adding_trauma = 0.50

onready var camera = $Camera
onready var spikes = $Spikes
onready var hit_sound = $HitSound
onready var label = $CanvasLayer/TypeLabel
onready var amount_bar = $CanvasLayer/AddedAmountBar
onready var amount_label = $CanvasLayer/AmountLabel
onready var trauma_bar = $CanvasLayer/TraumaBar
onready var trauma_label = $CanvasLayer/TraumaLabel



func _ready():
	for spike in spikes.get_children():
		spike.connect("stepped", self, "_on_Spike_stepped")


func _on_Spike_stepped():
	camera.set_shake(adding_trauma)
	hit_sound.play()


func _physics_process(event):
	if Input.is_action_just_pressed("ui_up"):
		adding_trauma += 0.1
	if Input.is_action_just_pressed("ui_down"):
		adding_trauma -= 0.1
	if adding_trauma > 1.0:
		adding_trauma = 1.0
	elif adding_trauma < 0.0:
		adding_trauma = 0.0
	
	amount_bar.value = camera.amount
	amount_label.text = "Amount: " + str(stepify(camera.amount, 0.01))
	trauma_bar.value = camera.trauma
	trauma_label.text = "Trauma: " + str(stepify(camera.trauma, 0.01))
	if Input.is_action_just_pressed("ui_right")\
	or Input.is_action_just_pressed("ui_left"):
		if camera.type == camera.ROUGH:
			camera.type = camera.SMOOTH
			label.text = "SMOOTH"
		elif camera.type == camera.SMOOTH:
			camera.type = camera.ROUGH
			label.text = "ROUGH"



