@tool
extends EditorPlugin

var custom_play_button : Button
var hidden_old_play_button : Button
var editor_settings : EditorSettings
var editor_command_palette : EditorCommandPalette

var rider_launch_http : RiderLaunchHttp

const SETTING_BASE_URL := "rider_launch/Base Url"
const SETTING_PORT := "rider_launch/Port"
const SETTING_EXECUTION_TYPE := "rider_launch/Execution Type"
const SETTING_CONFIG_TO_EXECUTE := "rider_launch/Config to execute"


func _enter_tree():
	await get_tree().process_frame
	editor_settings = get_editor_interface().get_editor_settings()
	editor_command_palette = get_editor_interface().get_command_palette()
	_init_settings()

	rider_launch_http = RiderLaunchHttp.new()
	add_child(rider_launch_http)
	
	_replace_play_button()


func _exit_tree() -> void:
	if custom_play_button:
		custom_play_button.queue_free()
	if hidden_old_play_button:
		hidden_old_play_button.show()
	if rider_launch_http:
		rider_launch_http.queue_free()
	queue_free()


func _replace_play_button():
	var base: Control = get_editor_interface().get_base_control()
	
	var play_button: Node = _find_editor_run_bar(base).get_child(0).get_child(0).get_child(0)
	
	if play_button and play_button is Button:
		hidden_old_play_button = play_button
		hidden_old_play_button.hide()

		# Since we cannot intercept the actual play button we will hide the real and create a fake one that do the job
		custom_play_button = Button.new()
		custom_play_button.tooltip_text = "Play With Rider IDE"
		custom_play_button.icon = play_button.icon #Incognito
		custom_play_button.flat = true 
		custom_play_button.focus_mode = Control.FOCUS_NONE
		
		var parent: Node = play_button.get_parent()
		var index: int = parent.get_children().find(play_button)
		parent.add_child(custom_play_button)
		parent.move_child(custom_play_button, index)
		
		custom_play_button.pressed.connect(_on_custom_play_pressed)
		
func _find_editor_run_bar(root: Node) -> Node:
	#We go recursively accross godot base control childs until we found the EditorRunBar
	for child in root.get_children():
		if child is Control and child.name.contains("EditorRunBar"):
			return child
		var result: Node = _find_editor_run_bar(child)
		if result:
			return result
	return null

func _on_custom_play_pressed():
	rider_launch_http.request_execution(editor_settings.get_setting(SETTING_BASE_URL), 
		editor_settings.get_setting(SETTING_PORT), 
		editor_settings.get_setting(SETTING_EXECUTION_TYPE), 
		editor_settings.get_setting(SETTING_CONFIG_TO_EXECUTE)
	)
	
func _init_settings():
	if not editor_settings.has_setting(SETTING_BASE_URL):
		editor_settings.set_setting(SETTING_BASE_URL, "localhost")
		editor_settings.add_property_info({
			"name": SETTING_BASE_URL,
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT
		})

	if not editor_settings.has_setting(SETTING_PORT):
		editor_settings.set_setting(SETTING_PORT, 5555)
		editor_settings.add_property_info({
			"name": SETTING_PORT,
			"type": TYPE_INT,
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "1,65535",
			"usage": PROPERTY_USAGE_DEFAULT
		})
		
		
	if not editor_settings.has_setting(SETTING_EXECUTION_TYPE):
		editor_settings.set_setting(SETTING_EXECUTION_TYPE, "debug")
		editor_settings.add_property_info({
			"name": SETTING_EXECUTION_TYPE,
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": "debug",
			"usage": PROPERTY_USAGE_DEFAULT
		})

	if not editor_settings.has_setting(SETTING_CONFIG_TO_EXECUTE):
		editor_settings.set_setting(SETTING_CONFIG_TO_EXECUTE, "Player GDScript")
		editor_settings.add_property_info({
			"name": SETTING_CONFIG_TO_EXECUTE,
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT
		})
		