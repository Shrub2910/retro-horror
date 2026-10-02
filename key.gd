extends Item

func use(player: Player):
	player.inventory.key_count += 1
	super(player)
	
