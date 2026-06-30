local player = {
	extends = CharacterBody3D;
	move_speed = 200;
	speed_loss = 400;
	turn_speed = 3;
	max_tilt = 25;
	max_speed = 1000;
	direction = Vector3.ZERO;
	shoot_laser = signal("position", "direction")
}

function player:_ready()
ShipModel = self:get_node("craft_speederD")
end


function player:_physics_process( dt )
	local direction_x = Input:get_axis("Strafe_Left", "Strafe_Right")
	local direction_z = Input:get_axis("Forward", "Back")
	self.direction = Vector3(direction_x, 0, direction_z)
	local velocity_input = self.global_transform.basis * (self.direction * self.move_speed * dt)
	self.velocity = (self.velocity + velocity_input ):limit_length(self.max_speed) -- this is to get sliding motion of SPACE
	self.velocity = Vector3(self.velocity.x, sin((Time:get_ticks_msec() / 500)) * 5,self.velocity.z) -- levitating effect
	self:move_and_slide()
	self:rotate_y(-direction_x * self.turn_speed * dt)


	--V { speed loss over time } V--

	local local_velocity = self.global_transform.basis:inverse() * self.velocity -- turn current ship's rotation into relative coordinates
	if (direction_x == 0) then
		local_velocity.x = move_toward(local_velocity.x, 0, self.speed_loss * dt)
	end

		if (direction_z == 0) then
		local_velocity.z = move_toward(local_velocity.z, 0, self.speed_loss * dt)
	end

	self.velocity = self.global_transform.basis * local_velocity -- convert back into global coordinate


	--V { slight rotation in direction of turn } V--
	self.current_tilt = move_toward(self.current_tilt, -direction_x * self.max_tilt * dt, self.turn_speed * dt)
	ShipModel.rotation = Vector3(ShipModel.rotation.x, ShipModel.rotation.y, self.current_tilt)


	if Input:is_action_just_pressed("Laser") then
		self.shoot_laser:emit(self.global_position, self.global_transform.basis)
	end

end



return player
