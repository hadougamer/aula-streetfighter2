extends KinematicBody2D

const UP 			= Vector2(0,-1)
const GRAVITY 		= 20
const SPEED 		= 200
const JUMP_HEIGHT 	= -650

var special = null
var motion = Vector2()
var hero_direction = 1 

func _ready():
	$Sprite.flip_h = false

func shoryuken():
	pass
	#$"../FX/Shoryuken".play()

func hadouken():
	$"../FX/Hadouken".play()
	
	var pre_hadouken = preload("res://scenes/assets/Hadouken.tscn")
	var hadouken = pre_hadouken.instance()
	
	hadouken.set_direction( hero_direction )
	hadouken.position.y = self.position.y - 70
	
	if hero_direction == 0:
		hadouken.position.x = self.position.x - 190;
	else:
		hadouken.position.x = self.position.x + 190;

	get_parent().add_child(hadouken)

func set_special( special_name ):
	print("## Special Name ##")
	print(special_name)

	self.special = special_name

func _physics_process(delta):
	motion.y += GRAVITY

	if( self.special == "shoryuken" ):
		$Sprite.position.y = -70
	else:
		$Sprite.position.y = 0

	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		$Sprite.play('walking')
		motion.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		$Sprite.play('walking')
		motion.x = SPEED
	else:
		if not self.special:
			$Sprite.play('idle')
		else:
			if( self.special == "shoryuken" ):
				$"../FX/Shoryuken".play()
				
			$Sprite.play( self.special )

		motion.x = 0

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite.play('jump')

	motion = move_and_slide(motion, UP)

func _on_Sprite_animation_finished():
	var name = $Sprite.get_animation()
	if name == "hadouken":
		self.hadouken()
		self.special = null
	elif name == "shoryuken":
		self.shoryuken()
		self.special = null
