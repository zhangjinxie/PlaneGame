targetPlatForm = cc.Application:getInstance():getTargetPlatform()
frameCache = cc.SpriteFrameCache:getInstance()
winSize = cc.Director:getInstance():getWinSize()
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

SOUNDKEY = "soundKey"
MUSICKEY = "musicKey"

NodeType = {
	enemy = 100,
	hero = 200,
	bullet = 300,
	explosion = 400
}

HomeBtnType = {
	start = 1,
	setting = 2,
	help = 3
}

EnemyType = {
	plane1 = 101,
	plane2 = 102,
	planet1 = 103,
	planet2 = 104,
}
EnemyAtt = {
	plane1 = {id = EnemyType.plane1, HP = 5, vt = cc.p(0, -100), rota = 0, name = "gameplay.enemy-1.png", score = 2},
	plane2 = {id = EnemyType.plane2, HP = 7, vt = cc.p(0, -150), rota = 0, name = "gameplay.enemy-2.png", score = 3},
	planet1 = {id = EnemyType.planet1, HP = 10, vt = cc.p(0, -120), rota = 1, name = "gameplay.stone1.png", score = 4},
	planet2 = {id = EnemyType.planet2, HP = 12, vt = cc.p(0, -80), rota = 0.5, name = "gameplay.enemy.planet.png", score = 5},
}

FightType = {
	hero1 = 201
}
FightAtt = {
	hero1 = {id = FightType.hero1, HP = 10, name = "gameplay.fighter.png"}
}

BulletType = {
	bullet1 = 301
}
BulletAtt = {
	bullet1 = {id = BulletType.bullet1, vt = cc.p(0, 200), name = "gameplay.bullet.png"}
}