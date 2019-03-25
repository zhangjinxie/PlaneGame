local Bullet = class("Bullet", function() return cc.Sprite:create() end)

function Bullet:create(att)
	local bullet = Bullet.new(att)
	return bullet
end

function Bullet:ctor(att)
	self:setSpriteFrame(att.name)
	self:setTag(att.id)
	self.volecity = att.vt
end

function Bullet:shootBulletFromMyHero()

	local function update(delta)
		local x, y = self:getPosition()
		self:setPosition(cc.p(x, y + self.volecity.y * delta))
		x, y = self:getPosition()
		if y > winSize.height then
			self:setVisible(false)
			self:unscheduleUpdate()
		end
	end

	self:scheduleUpdateWithPriorityLua(update, 0)
end
return Bullet