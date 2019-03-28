local MyHero = class("MyHero", function() return cc.Sprite:create() end)

function MyHero:create(att)
	local hero = MyHero.new(att)
	return hero
end

function MyHero:ctor(att)
	self:setTag(att.id)
	self:setSpriteFrame(att.name)
	self.nodeType = NodeType.hero
	self.HP = 0
	self.initHP = att.HP
	local verts = {
	    cc.p(-43.5,15.5),
	    cc.p(-23.5,33),
	    cc.p(28.5,34),
	    cc.p(48,17.5),
	    cc.p(0,-39.5)
	}

	local body = cc.PhysicsBody:create()
	body:addShape(cc.PhysicsShapePolygon:create(verts))
	body:setCategoryBitmask(0x02)
	body:setCollisionBitmask(0x00)
	body:setContactTestBitmask(0x01)

	self:setPhysicsBody(body)
	self:spawn()

end

function MyHero:setPo(x, y)
	if x < self:getContentSize().width/2 then
		x = self:getContentSize().width/2
	elseif x > winSize.width - self:getContentSize().width/2 then
		x = winSize.width - self:getContentSize().width/2
	end

	if y < self:getContentSize().height/2 then
		y = self:getContentSize().height/2
	elseif y > winSize.height - self:getContentSize().height/2 then
		y = winSize.height - self:getContentSize().height/2
	end
	self:setPosition(cc.p(x, y))
end

function MyHero:spawn()
	self.HP = self.initHP
	self:setPosition(cc.p(winSize.width/2, self:getContentSize().height/2))
end
return MyHero