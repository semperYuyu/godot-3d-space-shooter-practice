local player = {
	extends = CharacterBody3D;
	move_speed = 50;
	turn_speed = 5;
	direction = Vector3.ZERO;
}

function player:_physics_process( dt )
	local direction_x = Input:get_axis("Strafe_Left", "Strafe_Right")
	local direction_z = Input:get_axis("Forward", "Back")

	self.direction = Vector3(direction_x, 0, direction_z)
	self.velocity = self.direction * self.move_speed
	self:move_and_slide()
end



return player
