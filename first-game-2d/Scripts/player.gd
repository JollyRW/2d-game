extends CharacterBody2D


const SPEED = 110.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var death_screen: PackedScene = preload("res://Scenes/death_screen.tscn")
@onready var healthbar: ProgressBar = $healthbar

var health: float
var max_health: float = 100.0


func _ready():
	health = max_health
	healthbar.max_value = max_health
	healthbar.value = health
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	# Applies the movement
	if direction: 
		velocity.x = direction * SPEED
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Flips Sprite - access animatedsprite and flip on horizontal axis
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Plays Animations - access animsprite and plays idle/run animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else: animated_sprite.play("run")
	else: animated_sprite.play("jump")
	
	# Plays Character Sounds
	if velocity.y < 0 and is_on_floor():
			animation_player.play("jump_sound")
			animation_player.stop()
	move_and_slide()
	# Draws the death screen
func show_death_screen():
	var death_screenz = death_screen.instantiate()
	get_tree().current_scene.add_child(death_screenz)
	#get_tree().paused = true
	
	# Player death
func die():
	animation_player.play("death_sound")
	get_node("CollisionShape2D").queue_free()
	animated_sprite.flip_v = true
	Engine.time_scale = 0.1
	show_death_screen()
	health = 0
	healthbar.value = health
	
	# Function to make player take damage and adds a sound when hit
func take_damage(amount: float):
	health -= amount
	health = clamp(health, 0, max_health)
	healthbar.value = health
	animation_player.play("hurt_sound")
	animation_player.stop()
	
func health_pickup(amount: float):
	health += amount
	health = clamp(health, 0, max_health)
	healthbar.value = health
	
