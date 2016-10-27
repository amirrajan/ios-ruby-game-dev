class GameScene < SKScene
  include ScreenSizes

  def didMoveToView view
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    self.view.multipleTouchEnabled = true
    @squares = []
  end

  def touchesBegan touches, withEvent: _
    touches.allObjects.each do |t|
      @squares << add_sprite(t.locationInNode(self).x,
                             t.locationInNode(self).y,
                             'square.png')
    end
  end

  def add_sprite x, y, path
    texture = SKTexture.textureWithImageNamed path
    sprite = SKSpriteNode.spriteNodeWithTexture texture
    sprite.position = CGPointMake x, y
    addChild sprite
    sprite
  end

  def update currentTime
    @squares.each { |s| s.zRotation += 0.1 }
  end
end
