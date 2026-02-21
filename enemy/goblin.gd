extends Enemy

func _physics_process(delta: float) -> void:
	if health<=0:
		death_state()
	else :
		movements(delta)
	if !knockBack:
		flip_sprite(false,true)

func simpleAttack()->void:
	var distance=position.distance_to(PLAYER.position)
	if distance < attack_radios and health>0:
		$AnimationTree.set("parameters/AttackOneShot/request",AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)



func _on_attack_timer_timeout() -> void:
	simpleAttack()
	
