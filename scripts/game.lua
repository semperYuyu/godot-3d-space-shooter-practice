local game = {
	extends = Node3D,
};

function game:_ready()
	LaserScene = ResourceLoader:load("res://scenes/projectiles/laser.tscn")
	MeteoriteScene = ResourceLoader:load("res://scenes/projectiles/meteorite.tscn")
	LaserArrayNode = self:get_node("Lasers") -- please dont name them like this; the variable is fine the node isn't
	MeteoriteArrayNode = self:get_node("Meteorites")
	PlayerNode = self:get_node("Player")
	Random = RandomNumberGenerator:new()
end;

function game:_on_player_shoot_laser(position, direction)
	local laser = LaserScene:instantiate()
	laser.position = position
	laser.direction = direction
	LaserArrayNode:add_child(laser)
end;

function game:_on_meteorite_spawn_timer_timeout()
	Random:randomize()
	local random_angle = Random:randi_range(0, 360) -- get random angle from 0 to 2pi
	random_angle = math.rad(random_angle) -- convert to radians

	local radius = 1000
	local x_offset = radius * math.cos(random_angle)
	local z_offset = radius * math.sin(random_angle)
	local player_position = PlayerNode.position
	local meteorite = MeteoriteScene:instantiate()
	meteorite.position = player_position + Vector3(x_offset, -50, z_offset)
	meteorite.direction = (player_position - meteorite.position):normalized();
	meteorite.target = player_position
	MeteoriteArrayNode:add_child(meteorite)
end

return game;
