class GameScene < SKScene
  include ScreenSizes

  def didMoveToView view
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    @flying_thingy = add_sprite(
      device_screen_width.fdiv(2),
      device_screen_height.fdiv(2),
      "sprite_1.png",
      "flying thingy")
    @flying_thingy.xScale = 0.5
    @flying_thingy.yScale = 0.5
    @animation = SKAction.animateWithTextures(
      [
        texture("sprite_1.png"),
        texture("sprite_2.png"),
        texture("sprite_3.png"),
        texture("sprite_4.png"),
        texture("sprite_5.png")
      ],
      timePerFrame: 0.1)
    @flying_thingy.runAction(SKAction.repeatActionForever(@animation))
  end

  def texture path
    SKTexture.textureWithImageNamed(path)
  end

  def add_sprite x, y, path, name
    texture = SKTexture.textureWithImageNamed path
    sprite = SKSpriteNode.spriteNodeWithTexture texture
    sprite.position = CGPointMake x, y
    sprite.name = name
    addChild sprite
    sprite
  end

  def update currentTime
  end
end
