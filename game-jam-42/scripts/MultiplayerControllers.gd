extends Control

@export var	Address = "127.0.0.1"
@export var port = 4242
var peer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# this get called on the server and clients
func connected_to_server(id):
	print("Player connected to server ", id)

# this get called on server and clients
func connection_failed(id):
	print("Connection failed for ", id)

# this get called only from clients
func peer_connected(id):
	print("Player Connected ", id)
	sendPlayerInformation.rpc_id(1, multiplayer.get_unique_id())

# this get called only from clients
func peer_disconnected(id):
	print("Player Disconnected ", id)


# Need to modify if need more information (Active Spells / Skills)
@rpc("any_peer")
func sendPlayerInformation(id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] = {
			"id": id
		}
	if multiplayer.is_server():
		for i in GameManager.Players:
			if GameManager.Players[i].id != multiplayer.get_unique_id():
				sendPlayerInformation.rpc(GameManager.Players[i].id)

@rpc("any_peer", "call_local")
func startGame():
	var scene = load("res://scenes/stage.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func _on_host_button_down() -> void:
	Address = "0.0.0.0"
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("Cannot host: ", error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_NONE)
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players!")
	sendPlayerInformation(multiplayer.get_unique_id())
	



func _on_join_button_down() -> void:
	peer = ENetMultiplayerPeer.new()
	# Maybe add input to enter the ip address
	peer.create_client($TextEdit.text, port)
	peer.get_host().compress(ENetConnection.COMPRESS_NONE)
	multiplayer.set_multiplayer_peer(peer);


func _on_start_game_button_down() -> void:
	startGame.rpc()
	pass # Replace with function body.
