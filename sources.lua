ui = {
    ['sound'] = {
        ['win'] = love.audio.newSource("assets/audio/ui/winSound1.mp3", "static"),
        ['lose'] = love.audio.newSource("assets/audio/ui/loseSound1.mp3", "static"),
        ['contactWithMouse'] = love.audio.newSource("assets/audio/ui/jump.wav", "static"),
        ['contactWithGround'] = love.audio.newSource("assets/audio/ui/pop.mp3", "static"),
        ['click'] = love.audio.newSource('assets/audio/ui/click.mp3', 'static'),
        ['abertura'] = love.audio.newSource('assets/audio/music/Zoom.mp3'),
        ['background'] = love.audio.newSource('assets/audio/music/You_Like_It.mp3'),
    },

    ['image'] = {
        ['locked'] = love.graphics.newImage("assets/png/ui/locked.png"),
        ['play'] = love.graphics.newImage("assets/png/ui/button/@128px/play-right.png"),
        ['stop'] = love.graphics.newImage("assets/png/ui/button/@128px/cross.png"),
        ['refresh'] = love.graphics.newImage("assets/png/ui/button/@128px/refresh.png"),
        ['pause'] = love.graphics.newImage("assets/png/ui/button/@24px/two-vertical-parallel-lines.png"),
        ['speaker'] = love.graphics.newImage("assets/png/ui/button/@24px/musical-note.png"),
        ['monkey'] = love.graphics.newImage("assets/png/ui/002-monkey.png"),
        ['add'] = love.graphics.newImage("assets/png/ui/button/@24px/plus-sign-to-add.png"),
        ['delete'] = love.graphics.newImage("assets/png/ui/button/@24px/cross.png"),
        ['background'] = love.graphics.newImage("assets/png/scene/elements/background.png"),
        ['box1'] = love.graphics.newImage("assets/png/scene/tiles/01.png"),
        ['box2'] = love.graphics.newImage("assets/png/scene/tiles/02.png"),  
        ['tree1'] =  love.graphics.newImage("assets/png/scene/elements/tree.png"),
        ['tree2'] =  love.graphics.newImage("assets/png/scene/elements/tree1.png"),
        ['tree3'] =  love.graphics.newImage("assets/png/scene/elements/tree2.png"),
        ['scarecrow'] = love.graphics.newImage("assets/png/scene/elements/scarecrow.png")
    },

}


ui.sound.background:setLooping(true)
