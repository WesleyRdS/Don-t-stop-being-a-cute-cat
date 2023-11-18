extends Node

enum item_list{
	AMOUNT,
	a,
	b,
	c,
	d,
	NAME
}

var inventory_list: Array

func send_item(list: Array) -> void:
	var new_list: Array = list.duplicate(true)
	
	for i in inventory_list.size():
		if inventory_list[i][item_list.NAME] == new_list[item_list.NAME]:
			if inventory_list[i][item_list.AMOUNT] < 9:
				inventory_list[i][item_list.AMOUNT] += 1
				get_tree().call_group("inventory", "_update_item_slot", i, inventory_list[i][item_list.AMOUNT])
				return
				
	inventory_list.append(new_list)
	get_tree().call_group("inventory", "_create_item_slot", new_list)
	
func update_slot(slot_index: int, new_amount: int) -> void:
	inventory_list[slot_index][item_list.AMOUNT] = new_amount
	get_tree().call_group("inventory", "_update_item_slot", slot_index, new_amount)
	
func delete_slot(slot_index: int) -> void:
	inventory_list.remove_at(slot_index)
	get_tree().call_group("inventory", "_delete_inventory_slot", slot_index)
