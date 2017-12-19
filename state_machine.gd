# Finite State machine
extends Node

var last_state setget , get_last_state
var current_state setget set_current_state, get_current_state

func _ready():
	set_process_input(true)
	set_process(true)
	set_fixed_process(true)
	
func _input(event):
	call_deferred("global_input", event)
	
	if current_state:
		if has_method(current_state + "_input"):
			call_deferred(current_state + "_input", event)
	
func _process(delta):
	call_deferred("global_pre_update")
	
	if current_state:
		if has_method(current_state + "_update"): 
			call_deferred(current_state + "_update")
		
	call_deferred("global_post_update")
	
func _fixed_process(delta):
	call_deferred("global_pre_fixed_update")
	
	if current_state:
		if has_method(current_state + "_fixed_update"): 
			call_deferred(current_state + "_fixed_update")
		
	call_deferred("global_post_fixed_update")
	
func set_current_state(new_state):
	if current_state == new_state: return
	
	call_deferred("global_exit")
	if current_state:
		if has_method(current_state + "_exit"): 
			call_deferred(current_state + "_exit")
	
	last_state = current_state
	current_state = new_state
	
	call_deferred("global_enter")
	if current_state:
		if has_method(current_state + "_enter"): 
			call_deferred(current_state + "_enter")
	
func get_current_state():
	return current_state
	
func set_last_state():
	pass
	
func get_last_state():
	return last_state
	
func global_input(event):
	pass
	
func global_enter():
	pass
	
func global_exit():
	pass

func global_pre_update():
	pass
	
func global_post_update():
	pass
	
func global_pre_fixed_update():
	pass
	
func global_post_fixed_update():
	pass
