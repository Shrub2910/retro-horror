extends Node
class_name Inventory

var key_count := 0
var current_item: Item
var battery_percentage = 100
var number_of_coins = 0
var lantern_time_left = 0

func reset():
	key_count = 0
	current_item = null
	battery_percentage = 100
	number_of_coins = 0
	lantern_time_left = 0
