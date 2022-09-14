extends KinematicBody2D

onready var damage_hitbox = $hitbox/attack_hitbox
onready var damage_hitbox_area = $hitbox
onready var audio_manager = $audio_manager
onready var sprite = $sprite
onready var particle = $Particles2D

var velocity = 3
var speed = 60
var motion = Vector2()
var hit = 0
func _ready():
	global_position = get_parent().global_position

# 14:00
func start(dir):
	if dir == "up" || dir =="down":
		$sprite.rotation_degrees = 0
		if dir == "down": 
			motion.y = speed
		else: 
			motion.y = -speed
	if dir == "left" || dir =="right":
		$sprite.rotation_degrees = 0
		if dir == "left": 
			motion.x = -speed
		else: 
			motion.x = speed
func _physics_process(_delta):
	motion = move_and_slide(motion)
	if $ray.is_colliding() == true && $ray.get_collider().get("TYPE") != null:
		if $ray.get_collider().get("TYPE") == "Player":
			pass
		else: 
			$ray.get_collider().get("TYPE") != "Player"
			pass
	if $ray.is_colliding() == true && $ray.get_collider().get("TYPE") == null:
		queue_free()
		

func destroy():
	velocity = 0
	particle.emitting = false
	sprite.play("destroy")

func _on_sprite_animation_finished():
	var anim = sprite.animation
	if anim == "destroy":
		self.queue_free()


func _on_hitbox_area_entered(_area):
	destroy()
