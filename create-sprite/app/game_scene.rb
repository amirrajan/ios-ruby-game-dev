class GameScene < SKScene
  include ScreenSizes

  def didMoveToView view
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    @square = add_sprite device_screen_width.fdiv(2),
                         device_screen_height.fdiv(2),
                         'square.png'
  end

  def add_sprite x, y, path
    texture = SKTexture.textureWithImageNamed path
    sprite = SKSpriteNode.spriteNodeWithTexture texture
    sprite.position = CGPointMake x, y
    addChild sprite
    sprite
  end

  def update currentTime
    @square.zRotation += 0.1
  end
end
