local Enemy = class("Enemy", function() return cc.Sprite:create() end)

function Enemy:create(enemyAtt)
	local enemy = Enemy.new(enemyAtt)
	return enemy
end

function Enemy:ctor(enemyAtt)
	local att = enemyAtt
	self:setTag(att.id)
	self.nodeType = NodeType.enemy
	self:setSpriteFrame(att.name)
	self.HP = att.HP
	self.velocity = att.vt
	self.initHP = 0

	local body = cc.PhysicsBody:create()
	if att.id == EnemyType.planet1 or att.id == EnemyType.planet2 then
		body:addShape(cc.PhysicsShapeCircle:create(self:getContentSize().width/2 - 5))
	elseif att.id == EnemyType.plane1 then
		local verts ={
		    cc.p(-2.5,-45.75),
		    cc.p(-29.5,-27.25),
		    cc.p(-53, -0.25),
		    cc.p(-34,43.25),
		    cc.p(28, 44.25),
		    cc.p(55,-2.25)
		}
		body:addShape(cc.PhysicsShapePolygon:create(verts))
	elseif att.id == EnemyType.plane2 then
		local verts ={
		    cc.p(1.25, 32.25),
		    cc.p(36.75, -4.75),
		    cc.p( 2.75, -31.75),
		    cc.p(-35.75,-3.25)
		}
		body:addShape(cc.PhysicsShapePolygon:create(verts))
	end
	self:setPhysicsBody(body)
	body:setCategoryBitmask(0x01)
	body:setCollisionBitmask(0x00)
	body:setContactTestBitmask(0x02)


	local function update(delta)
		self:setRotation(self:getRotation() + att.rota)
		local x, y = self:getPosition()
		self:setPosition(cc.p(x, y + self.velocity.y * delta ))
		x, y = self:getPosition()
		if y < -self:getContentSize().height/2 then
			self:spawn()
		end
	end

	self:scheduleUpdateWithPriorityLua(update, 0)

	local function onNodeEvent(eventType)
		if eventType == "exit" then
			self:unScheduleUpdate()
		end
	end

	self:registerScriptHandler(onNodeEvent)
	self:spawn()
end

function Enemy:spawn()
	local x = math.random(self:getContentSize().width/2, winSize.width - self:getContentSize().width/2)
	local y = winSize.height + self:getContentSize().height/2
	self:setPosition(cc.p(x, y))
	self.initHP = self.HP
end
return Enemy