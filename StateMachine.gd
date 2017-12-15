# State machine
extends Node

var last_state setget set_last_state, get_last_state
var current_state setget set_current_state, get_current_state

func _ready():
	set_process_input(true)
	set_process(true)
	set_fixed_process(true)
	
func _input(event):
	if has_method(current_state + "_input"): 
		call_deferred(current_state + "_input")
	call_deferred("global_input", event)
	
	
func _process(delta):
	if has_method(current_state + "_update"): 
		call_deferred(current_state + "_update")
	call_deferred("global_update")
	
func _fixed_process(delta):
	if has_method(current_state + "_fixed_update"): 
		call_deferred(current_state + "_fixed_update")
	call_deferred("global_fixed_update")
	
func get_current_state():
	return current_state
	
func set_current_state(value):
	if (current_state == value): return
	if (current_state != null):
		if has_method(current_state + "_exit"): 
			call_deferred(current_state + "_exit")
	last_state = current_state
	current_state = value
	if has_method(current_state + "_enter"): 
		call_deferred(current_state + "_enter")
	
func set_last_state(value):
	print("Cannot change private variable last_state in " + str(self))
	
func get_last_state():
	return last_state
	
func global_input(event):
	pass

func global_update():
	pass
	
func global_fixed_update():
	pass

