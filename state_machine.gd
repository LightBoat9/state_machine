# Finite State machine
extends Node

var __last_state setget __set_last_state, get_last_state
var __current_state setget set_current_state, get_current_state

func _ready():
	set_process_input(true)
	set_process(true)
	set_fixed_process(true)
	
func _input(event):
	call_deferred("global_input", event)
	
	if __current_state:
		if has_method(__current_state + "_input"):
			call_deferred(__current_state + "_input", event)
	
func _process(delta):
	call_deferred("global_pre_update")
	
	if __current_state:
		if has_method(__current_state + "_update"): 
			call_deferred(__current_state + "_update")
		
	call_deferred("global_post_update")
	
func _fixed_process(delta):
	call_deferred("global_pre_fixed_update")
	
	if __current_state:
		if has_method(__current_state + "_fixed_update"): 
			call_deferred(__current_state + "_fixed_update")
		
	call_deferred("global_post_fixed_update")
	
func set_current_state(new_state):
	if __current_state == new_state: return
	
	call_deferred("global_exit")
	if __current_state:
		if has_method(__current_state + "_exit"): 
			call_deferred(__current_state + "_exit")
	
	__last_state = __current_state
	__current_state = new_state
	
	call_deferred("global_enter")
	if __current_state:
		if has_method(__current_state + "_enter"): 
			call_deferred(__current_state + "_enter")
	
func get_current_state():
	return __current_state
	
func __set_last_state():
	pass
	
func get_last_state():
	return __last_state
	
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
