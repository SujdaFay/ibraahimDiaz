extends Enemy
@onready var animationAttack = $AnimationTree.get_tree_root().get_node("AttackAndBlock")

var attackTypes:={
	"attack":"attack",
	"block":"sheild"
}

func _physics_process(delta: float) -> void:
	if health<=0:
		death_state()
	else :
		movements(delta)
	if !knockBack:
		flip_sprite(false,true)
		
		

func simpleAttack()->void:
	#print("Attacking")
	var distance=position.distance_to(PLAYER.position)
	if distance < attack_radios and health>0:
		var rand= randi_range(0,1)
		if rand==0:
			isBlocking=true
		else :
			isBlocking=false
		animationAttack.animation=attackTypes["attack" if rand==1 else "block"]
		$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)



func _on_attack_timer_timeout() -> void:
	simpleAttack()
	
	
