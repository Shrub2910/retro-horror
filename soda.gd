extends Item

func use(player: Player):
	player.speed_boost = 5.0
	super(player)
