extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -280.0
const GRAVITY:=400
var state="idle"
var canAttack:=true
var death=false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_tree: AnimationTree = $AnimationTree

@onready var anim_state=animation_tree.get("parameters/MoveStateMachine/playback")
@onready var attack_timer: Timer = $attackTimer

#@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar/ProgressBar

func _ready() -> void:
	health_bar.value=PlayerState.health

func _physics_process(delta: float) -> void:
	
	if PlayerState.health==0:
		death=true
	#if death:
		#return
	is_on_floor()
	if not PlayerState.death:
		movement()
		jump_and_gravity(delta)
		abilitys()
	move_and_slide()
	if velocity.x < 0:
		animated_sprite_2d.scale.x = -1
		$HitBox.scale.x=-1
		#ray_cast_2d.scale.x=-1
	if velocity.x > 0:
		animated_sprite_2d.scale.x = 1
		$HitBox.scale.x=1
	anim_state.travel(state)
	


func movement()->void:
	var direction=Input.get_axis("a","d")
	if direction:
		state="walk"
		velocity.x=direction*SPEED
		
	else :
		state="idle"
		velocity.x=move_toward(velocity.x,0,SPEED)

func jump_and_gravity(delta)->void:
	if velocity.y>0:
		state="fall"
	if velocity.y<0:
		state="jump"
	if not is_on_floor():
		velocity.y+=GRAVITY*delta
	if Input.is_action_just_pressed("w")and is_on_floor():
		velocity.y=JUMP_VELOCITY

func abilitys():
	if Input.is_action_just_pressed("attack"):
		if canAttack:
			attack_timer.start()
			$AnimationTree.set("parameters/OneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			canAttack=false


func _on_attack_timer_timeout() -> void:
	canAttack=true
	#print("time to attack agin")

func hit()->void:
	print("taking a damage")
	if $DamageTimer.is_stopped():
		PlayerState.healthDec()
		health_bar.value=PlayerState.health
