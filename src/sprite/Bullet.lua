local Bullet = class("Bullet", function() return cc.Sprite:create() end)

function Bullet:create(att)
	local bullet = Bullet.new(att)
	return bullet
end

function Bullet:ctor(att)
	self:setSpriteFrame(att.name)
	self:setTag(att.id)
	self.nodeType = NodeType.bullet
	self.volecity = att.vt

	local body = cc.PhysicsBody:createBox(self:getContentSize())
	body:setCategoryBitmask(0x2)
	body:setCollisionBitmask(0x00)
	body:setContactTestBitmask(0x01)
	body:setTag(111)
	self:setPhysicsBody(body)
end

function Bullet:shootBulletFromMyHero()
	local function update(delta)
		local x, y = self:getPosition()
		self:setPosition(cc.p(x, y + self.volecity.y * delta))
		x, y = self:getPosition()
		if y > winSize.height then
			self:removeFromWorld()
		end
	end
	self:scheduleUpdateWithPriorityLua(update, 0)

	local function noNodeEvent(eventType)
		-- print('=========bullet nodeEvent', eventType)
		if eventType == "exitTransitionStart" then
			self:unscheduleUpdate()
		end
	end
	self:registerScriptHandler(noNodeEvent)
end

function Bullet:removeFromWorld()
	self:setVisible(false)
	self:unscheduleUpdate()
	if self:getPhysicsBody() then
		self:getPhysicsBody():setEnabled(false)
	end
end
return Bullet