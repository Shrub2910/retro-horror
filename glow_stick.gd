extends Item

func use(player: Player):
	player.throw_glowstick.emit(player.global_position,player.transform.x)
	super(player)
