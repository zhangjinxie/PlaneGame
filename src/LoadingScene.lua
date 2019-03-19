
local LoadingScene = class("LoadingScene", function() return cc.Scene:create() end)

function LoadingScene:create()
	local scene = LoadingScene:new()
	scene:addChild(scene:createLayer())
	return scene
end

function LoadingScene:createLayer()
	local layer = cc.Layer:create()
	local targetPlatForm = cc.Application:getInstance():getTargetPlatform()
	local frameCache = cc.SpriteFrameCache:getInstance()
	if targetPlatForm == cc.PLATFORM_OS_IPHONE or targetPlatForm == cc.PLATFORM_OS_IPAD then
		loading_texture_plist = "texture/loading_texture_pvr.plist"
		loading_texture_res = "texture/loading_texture_pvr.gz"
		LostRoutes_plist = "texture/LostRoutes_Texture_pvr.plist"
		LostRoutes_res = "texture/LostRoutes_Texture_pvr.gz"
		sound1 = "sound/Blip.caf"
		sound2 = "sound/Explosion.caf"
		homeMusic = "sound/home_bg.aifc"
		gameMusic = "sound/game_bg.aifc"
	else
		loading_texture_plist = "texture/loading_texture.plist"
		loading_texture_res = "texture/loading_texture.png"
		LostRoutes_plist = "texture/LostRoutes_Texture.plist"
		LostRoutes_res = "texture/LostRoutes_Texture.png"
		sound1 = "sound/Blip.wav"
		sound2 = "sound/Explosion.wav"
		homeMusic = "sound/home_bg.mp3"
		gameMusic = "sound/game_bg.mp3"
	end

	frameCache:addSpriteFrames(loading_texture_plist)
	local animation = cc.Animation:create()
	for i = 1, 4 do
		local name = string.format("loding%d.png", i)
		local frame = frameCache:getSpriteFrameByName(name)
		animation:addSpriteFrame(frame)
	end
	animation:setDelayPerUnit(0.2)
	animation:setRestoreOriginalFrame(true)
	local loadingSprite = cc.Sprite:createWithSpriteFrameName("loding1.png")
	loadingSprite:setPosition(cc.p(0, 300))
	layer:addChild(loadingSprite)
	loadingSprite:runAction(cc.RepeatForever:create(cc.Animate:create(animation)))
	return layer
end
return LoadingScene