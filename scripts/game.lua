local game = {
	extends = Node3D,
};

function game:_ready()
	LaserScene = ResourceLoader:load("res://scenes/projectiles/laser.tscn")
	LaserArrayNode = self:get_node("Lasers") -- please dont name them like this; the variable is fine the node isn't
end;

function game:_on_player_shoot_laser(position, direction)
	print('omg no way')
	local laser = LaserScene:instantiate()
	laser.position = position
	laser.direction = direction
	LaserArrayNode:add_child(laser)
end;

return game;
