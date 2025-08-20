extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var alive = true

@onready var sprite = $AnimatedSprite2D
@onready var smierc_tekst: Label = $Smierc_tekst

func _physics_process(delta: float) -> void:
	if alive:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("gora") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("lewo", "prawo")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if is_on_floor() && direction !=0:
			sprite.play('bieganie')
		elif is_on_floor():
			sprite.play("domyślne")
		elif !is_on_floor():
			sprite.play("skok")
		if direction < 0:
			sprite.flip_h = true
		elif direction > 0:
			sprite.flip_h = false
		
		move_and_slide()
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	#else:
		#if Input.is_action_just_pressed("restart"):
			#get_tree().reload_current_scene()



func _on_area_2d_body_entered(body: Node2D) -> void:
	alive = false
	sprite.visible = false
	smierc_tekst.visible = true
