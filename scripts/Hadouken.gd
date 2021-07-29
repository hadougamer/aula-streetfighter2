extends KinematicBody2D

export(int) var speed = 450
export(int, "left", "right") var direction = 0

var bullet_dir=-1

func _ready():
	pass

func set_direction( dir ):
	self.direction = dir

func _physics_process(delta):
	if( direction == 0 ):
		# Left
		$Sprite.flip_h=true
		bullet_dir = -1
	else:
		# Right
		$Sprite.flip_h=false
		bullet_dir = 1
	
	var info = move_and_collide( Vector2(bullet_dir, 0) * speed * delta )

	if info && info.collider.is_in_group("enemies"):
		# Collides with a enemy
		info.collider.queue_free()
		self.queue_free()
	elif info && !info.collider.is_in_group("enemies"):
		# Collides with other thing
		self.queue_free()

func _on_Notifier_screen_exited():
	print("bullet exited")
	# Destroy this bullet
	self.queue_free()

