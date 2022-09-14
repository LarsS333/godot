extends KinematicBody2D



const TYPE = "trap"
const bullet = preload("res://Assets/Enemies/Trap/bullet2.tscn")
export(String) var dir = ""


var reload = 1.5
var timer = false

func _ready():
	if dir == "up":
		self.rotation_degrees = -180
	if dir == "right":
		self.rotation_degrees = 90
	if dir == "left":
		self.rotation_degrees = -90
	if dir == "down":
		self.rotation_degrees = -90


func _physics_process(delta):
	if timer == false: 
		$Timer.start()
		timer = true

	
func _on_Timer_timeout():
	if timer == true:	
		shoot()
		timer = false

func shoot():
	var b = bullet.instance()
	b.start(dir)
	self.add_child(b)
