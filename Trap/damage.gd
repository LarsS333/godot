extends Node2D
onready var damage_hitbox = $hitbox/attack_hitbox
onready var damage_hitbox_area = $hitbox
onready var audio_manager = $audio_manager
onready var hit_timer = $hit_timer


onready var particle = $Particles2D

export var atk_value = 10

var velocity = 3
var hit = 0
var speed = 60
var motion = Vector2()
var sfx_damage : AudioStream = load("res://Sounds/SFX/raclure - Damage SFX.wav")


func _ready():
	pass

#//////////////////////////////////////////////////

			
func _physics_process(_delta):
	if hit == 1:
		damage_hitbox_area.monitoring = false
	if hit == 0:
		damage_hitbox_area.monitoring = true

func _on_hitbox_body_entered(body):
	if body.name == "Player":
		if hit == 0 and body.current_state != body.DEAD:
			audio_manager.play_sfx(sfx_damage)
			body.instance_hit()
			Global.camera.shake(150, 0.4, 100)
			Global.frame_freeze(0.1, 0.4)
			body.hit = true
			body.emit_signal("damaged")
			Global.hp -= atk_value
			hit = 1
			hit_timer.start()
		else: pass

func _on_hit_timer_timeout():
	hit = 0
	pass
	
