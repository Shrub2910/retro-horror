extends Item

@export var lantern_time = 15

func use(player: Player):
	player.inventory.lantern_time_left = lantern_time
	super(player)
