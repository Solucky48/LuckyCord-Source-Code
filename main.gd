extends Control
var dark = false
@onready var send: Button = $ui/send
@onready var msg: LineEdit = $ui/msg
@onready var showup: RichTextLabel = $ui/showup
@onready var Name: LineEdit = $profile/Name
@onready var color: ColorPickerButton = $profile/Color
var username : String
var user_color : String
var message : String
var last = ""
var room_name = ""
var name_list = {}
func _process(delta: float) -> void:
	if not multiplayer.peer_connected.is_connected(_on_peer_connected):
		multiplayer.peer_connected.connect(_on_peer_connected)
	if not multiplayer.peer_disconnected.is_connected(_on_peer_disconnected):
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	if  Input.is_action_just_pressed("ui_text_newline"):
		_on_send_pressed()
func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(22252)
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer = peer
	$menu.hide()
	$hosting.hide()
	username = Name.text
	user_color = color.color.to_html(false)
	name_list[1] = username
	room_name = $hosting/RName.text
	$ui/room_name.text = room_name
	$"ui/Memberlist/1".text = str(name_list[1])
	showup.append_text(" [color=gray][i]SERVER: " + username + " started the chat room![/i][/color]\n")
func _on_join_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(str($joining/IP.text),22252)
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer = peer
	$menu.hide()
	$joining.hide()
	username = Name.text
	user_color = color.color.to_html(false)
func _on_peer_connected(id: int) -> void:
	await get_tree().create_timer(0.2).timeout
	rpc("_rpc_share_name", multiplayer.get_unique_id(), username)
	if multiplayer.is_server():
		rpc_id(id, "_rpc_sync_room_name", room_name)
@rpc("any_peer", "call_local")
func _rpc_sync_room_name(srv_room_name: String) -> void:
	room_name = srv_room_name
	$ui/room_name.text = room_name
@rpc("any_peer", "call_local")
func _rpc_share_name(sender_id: int, sender_name: String) -> void:
	if not name_list.has(sender_id):
		name_list[sender_id] = sender_name
		if sender_id != 1:
			showup.append_text(" [color=gray][i]SERVER: " + sender_name + " joined the chat![/i][/color]\n")
			var scrollbar = showup.get_v_scroll_bar()
			scrollbar.value = scrollbar.max_value
func _on_peer_disconnected(id: int) -> void:
	var leaving_name = ""
	if name_list.has(id):
		leaving_name = name_list[id]
		name_list.erase(id)
	showup.append_text(" [color=gray][i]SERVER: " + leaving_name + " left the chat...[/i][/color]\n")
	var scrollbar = showup.get_v_scroll_bar()
	scrollbar.value = scrollbar.max_value
func _on_send_pressed() -> void:
	if msg.text != "":
		rpc("_rpc_msg", username, msg.text, user_color)
		msg.text = ""
		print(name_list)
@rpc("any_peer", "call_local")
func _rpc_msg(user: String, msg: String, text_color: String) -> void:
	$"ui/Memberlist/1".text = str(name_list[1])
	var formatted_msg = " " + " [color=#"+text_color+"]" + user + "[/color]: " + msg + "\n"
	var formatted_msg_2 = "  " + msg + "\n"
	if user != last:
		showup.append_text(formatted_msg)
		last = user
	else:
		showup.append_text(formatted_msg_2)
	var scrollbar = showup.get_v_scroll_bar()
	scrollbar.value = scrollbar.max_value
func _on_save_pressed() -> void:
	$profile.hide()
func _on_profile_pressed() -> void:
	$profile.show()
func _on_dark_pressed() -> void:
	if dark == false:
		$ui/BG.show()
		$menu/BG.show()
		$profile/BG.show()
		$hosting/BG.show()
		$joining/BG.show()
		$settings/BG.show()
		dark = true
	elif dark == true:
		$ui/BG.hide()
		$menu/BG.hide()
		$profile/BG.hide()
		$hosting/BG.hide()
		$joining/BG.hide()
		$settings/BG.hide()
		dark = false
func _on_create_pressed() -> void:
	$hosting.show()
func _on_joining_pressed() -> void:
	$joining.show()
func _on_quit_pressed() -> void:
	get_tree().quit()
func _on_settings_pressed() -> void:
	$settings.show()
func _on_saveset_pressed() -> void:
	$settings.hide()
func _on_back_pressed() -> void:
	$hosting.hide()
	$joining.hide()
	pass # Replace with function body.
func _on_leave_pressed() -> void:
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
		$menu.show()
		showup.text = ""
	pass # Replace with function body.
