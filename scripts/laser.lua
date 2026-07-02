local laser = {
	extends = Area3D,
	speed = 250,
	direction = Vector3.ZERO
}

function laser:_ready()
	self.position = self.position + -self.direction.z
	self.forward = -self.direction.z -- self.direction comes from player's self.global_transform.basis which is their rotation data
	self:look_at(self.global_position + self.forward, Vector3.UP) -- inherits player's orientation
	tween = self:create_tween()
	tween:tween_property(self, "scale", Vector3(2, 2, 2), 0.4)
	DespawnTimer = self:get_node("DespawnTimer")
	DespawnTimer:start()
end

function laser:_physics_process(dt)
	self.position = self.position + (self.forward * self.speed * dt)
end

function laser:_on_despawn_timer_timeout()
	self:queue_free()
end
return laser
