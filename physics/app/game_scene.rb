class GameScene < SKScene
  include ScreenSizes

  def didMoveToView view
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    self.view.showsPhysics = true

    @ball = add_sprite(10,
                       device_screen_height,
                       'ball.png',
                       'circle')

    @ball.physicsBody = SKPhysicsBody.bodyWithCircleOfRadius(15)
    @wall = add_sprite(device_screen_width.fdiv(2),
                       60,
                       'wall.png',
                       'wall')

    @wall.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize CGSizeMake(1000, 25)
    @wall.physicsBody.dynamic = false
    @wall.zRotation = 0.5


    @wall2 = add_sprite(-200,
                       500,
                       'wall.png',
                       'wall')

    @wall2.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize CGSizeMake(1000, 25)
    @wall2.physicsBody.dynamic = false
    @wall2.zRotation = -0.5
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

  def didBeginContact _
  end
end
