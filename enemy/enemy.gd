extends CharacterBody2D
class_name Enemy
var gracity:=5000
@export var  health:=10.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var notice_radious:=300
@export var attack_radios:=100
@export var SPEED:=80
@onready var PLAYER=get_tree().get_first_node_in_group("PLAYER")
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var moveState=animation_tree.get("parameters/StateMachine/playback")
@onready var ray_cast_2d: RayCast2D = $HitBox/RayCast2D
#@onready var enemy_health_bar: Node2D = $Enemy_health_bar/TextureProgressBar
@onready var enamey_health_bar: TextureProgressBar = $Enemy_health_bar/TextureProgressBar
var isBlocking:=false
var knockBack:=false
var state="idle"

func _ready() -> void:
	enamey_health_bar.value=health

func movements(delta:float)->void:
	if knockBack:
		if not is_on_floor():
			velocity.y += gracity
		move_and_slide()
		return
		
	var distance=position.distance_to(PLAYER.position)
	var direction=(PLAYER.position-position).normalized()
	
	if distance < notice_radious:
		state="move"
		if distance > attack_radios:
			velocity.x = direction.x * SPEED
		else :
			state="idle"
			stopMovet()
	else :
		state="idle"
		stopMovet()
	velocity=velocity.limit_length(SPEED)
	if not is_on_floor():
		velocity.y+=gracity
	move_and_slide()
	moveState.travel(state)

func stopMovet()->void:
	velocity=velocity.move_toward(Vector2.ZERO,6.0)

func flip_sprite(posi:bool,neg:bool)->void:
	if velocity.x>0:
		sprite.flip_h=posi
		ray_cast_2d.scale.x=-1
	if velocity.x < 0:
		sprite.flip_h=neg
		ray_cast_2d.scale.x=1

func hit():
	var damage_timer=$Damage_Timer
	if health <=0:
		return
	if isBlocking:
		return
	if damage_timer.is_stopped():
		$AnimationTree.set("parameters/hurtOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE);
		health-=1
		hitEffect()
		enamey_health_bar.value=health
		damage_timer.start()


func hitEffect():
	knockBack = true
	const push_speed = 400
	var push_direction = (position - PLAYER.position).normalized()
	velocity = push_direction * push_speed
	await get_tree().create_timer(0.2).timeout
	knockBack = false


func death_state():
	var timer=get_tree().create_timer(1.5)
	state="death"
	moveState.travel(state)
	get_tree().queue_delete($CollisionShape2D)
	await timer.timeout
	self.queue_free()
