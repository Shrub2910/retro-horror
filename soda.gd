extends Item

func use(player: Player):
	player.speed_boost = 10.0
	super(player)
