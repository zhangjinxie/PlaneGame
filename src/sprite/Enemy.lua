local Enemy = class("Enemy", function() return cc.Sprite:create() end)

function Enemy:create(enemyAtt)
	local enemy = Enemy.new(enemyAtt)
	return Enemy
end

function Enemy:ctor(enemyAtt)
	self:setTag(enemyAtt.id)
	local att = enemyAtt
	dump(att, "===================attOfEnemy")
	self:setPosition(cc.p(winSize.width/2, winSize.height/2))

end
return Enemy