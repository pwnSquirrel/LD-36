extends Control

onready var parent = get_node("..")
onready var global = get_node("/root/global")
var first = true

var button_to_item = {}

var drag_item = null

func _ready():
	if(first):
		for i in get_children():
			i.connect("input_event", self, "_on_click", [i.get_name()])
		first = false
	
	update()
	set_process(true)
	
func _process(delta):
	update()
	
func _draw():
	if(drag_item != null):
		var mp = get_viewport().get_mouse_pos()
		draw_texture(drag_item.get_node("item").inventory_texture, Vector2(mp.x / parent.get_scale().x, mp.y / parent.get_scale().y))

		
		
func update_inventory():
	var items = global.get_items()
	
	for i in get_children():
		i.get_node("icon").set_texture(null)
	button_to_item = {}
	
	var pos = 0
	for i in items:
		get_node(str(pos) + "/icon").set_texture(items[i].get_node("item").inventory_texture)
		button_to_item[str(pos)] = i
		pos += 1
		
		
		
func _on_click(ev, button):
	if(ev.is_action_pressed("click")):
		if(button_to_item.has(button)):
			if(drag_item == null):
				drag_item = global.get_items()[button_to_item[button]]
			else:
				if(drag_item == global.get_items()[button_to_item[button]]):
					drag_item = null
				else:
					pass # combine