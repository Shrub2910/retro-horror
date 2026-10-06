extends Item

@export var sprite: AnimatedSprite2D
var collected := false

func use(player: Player):
	player.inventory.number_of_coins += 1
	print(player.inventory.number_of_coins)
	super(player)
