extends Item

func use(player: Player):
	player.inventory.battery_percentage += 25 
	if player.inventory.battery_percentage > 100: player.inventory.battery_percentage = 100
	super(player)
