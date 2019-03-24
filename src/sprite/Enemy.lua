local Enemy = class("Enemy", function() return cc.Sprite:create() end)

function Enemy:create(enemyAtt)
	local enemy = Enemy.new(enemyAtt)
	return enemy
end

function Enemy:ctor(enemyAtt)
	local att = enemyAtt
	self:setTag(att.id)
	self:setPosition(cc.p(winSize.width/2, winSize.height + self:getContentSize().height/2))
	self:setSpriteFrame(att.name)
	self.life = att.life
	self.velocity = att.vt

	local body = cc.PhysicsBody:create()
	if att.id == 2 or att.id == 3 then
		body:addShape(cc.PhysicsShapeCircle:create(self:getContentSize().width/2 - 5))
	elseif att.id == 1 then
		local verts ={
		    cc.p(-2.5,-45.75),
		    cc.p(-29.5,-27.25),
		    cc.p(-53, -0.25),
		    cc.p(-34,43.25),
		    cc.p(28, 44.25),
		    cc.p(55,-2.25)
		}
		body:addShape(cc.PhysicsShapePolygon:create(verts))
	elseif att.id == 4 then
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
	body:setCollisionBitmask(0x02)
	body:setContactTestBitmask(0x01)

	local function update(delta)
		print("---------------------")
	end

	self:scheduleUpdateWithPriorityLua(update, 0)
end
return Enemy