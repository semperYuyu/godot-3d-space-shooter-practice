local meteorite = {
	extends = Area3D,
	target = Vector3.ZERO,
	speed = 200,
}
function meteorite:_ready()
	print(self.position)
end
-- TODO: Make meteorite scene spawn in random spot around player; have it move slowly toward playe
-- 			 doesn't need to all happen inside of this file
function meteorite:_physics_process(dt)
	self.position = self.position + (self.speed * self.direction * dt)
end

function meteorite:_on_despawn_timer_timeout()
	self:queue_free()
end
return meteorite
