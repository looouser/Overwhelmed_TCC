extends Area2D
signal hit

@export var speed = 100 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_direita"):
		velocity.x += 1
	if Input.is_action_pressed("move_esquerda"):
		velocity.x -= 1 
	if Input.is_action_pressed("move_cima"):
		velocity.y -= 1
	if Input.is_action_pressed("move_baixo"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position.x = clamp(position.x,0,screen_size.x) 
	position.y = clamp(position.y,0,screen_size.y)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = 'playerwalk'
		$AnimatedSprite2D.flip_v = false 
		$AnimatedSprite2D.flip_h = velocity.x < 0 
		


func _on_body_entered(body):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred('disabled', true)
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
