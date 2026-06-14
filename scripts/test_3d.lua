local test_3d = {
	extends = Node3D,
}

local speed = 0.5
local colour = 0

function test_3d:_process(dt)
	local mesh3d = self:get_node("MeshInstance3D")
	mesh3d:translate(Vector3(-speed * dt, 0, 0)) -- move to the right (-x) every frame by 0.2 units * delta time
	mesh3d:rotate_x(speed * dt)
	mesh3d.mesh.material.albedo_color = Color(colour, colour, colour, 1) -- set colour of material to colour for all properties
	colour = math.fmod(colour + speed * dt, 1.0) -- increment colour by 0.2
end

return test_3d
