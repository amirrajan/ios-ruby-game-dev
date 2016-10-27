class GameScene < SKScene
  include ScreenSizes

  def didMoveToView view
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    self.physicsWorld.gravity = CGVectorMake(0, 0)
    self.physicsWorld.contactDelegate = self
    self.view.showsPhysics = true

    @ball = add_sprite(device_screen_width.fdiv(2),
                       60,
                       'ball.png',
                       'circle')

    @ball.physicsBody = SKPhysicsBody.bodyWithCircleOfRadius(20)
    @ball.physicsBody.dynamic = true
    @ball.physicsBody.categoryBitMask = 2
    @ball.physicsBody.contactTestBitMask = 4
    @ball.physicsBody.collisionBitMask = 0

    @wall = add_sprite(device_screen_width.fdiv(2),
                       device_screen_height.fdiv(2),
                       'wall.png',
                       'wall')

    @wall.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize CGSizeMake(500, 35)

    @wall.physicsBody.dynamic = true
    @wall.physicsBody.categoryBitMask = 4
    @wall.physicsBody.contactTestBitMask = 2
    @wall.physicsBody.collisionBitMask = 0
  end

  def init_explosion
    @explosion = SKEmitterNode.alloc.init
    @explosion.setParticleTexture SKTexture.textureWithImageNamed('explosion_particle.png')
    @explosion.setNumParticlesToEmit 200
    @explosion.setParticleBirthRate 450
    @explosion.setEmissionAngleRange 360
    @explosion.setParticleSpeed 1000
    @explosion.setParticleLifetimeRange 0.5
    @explosion.setParticleAlphaSpeed(-0.5)
    @explosion.setPosition CGPointMake(0, 0)
    @explosion.setParticleRotation 0.1
    @explosion.setParticleRotationRange 6
    @explosion.setParticlePositionRange CGVectorMake(10, 10)
    @explosion.setParticleBlendMode SKBlendModeAlpha
    @ball.addChild @explosion
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
    @ball_direction ||= 1

    if @ball.position.y > device_screen_height || @ball.position.y < 0
      @ball_direction = @ball_direction * -1
    end

    @ball.position = CGPointMake(
      @ball.position.x,
      (@ball.position.y) + 5 * @ball_direction
    )
  end

  def didBeginContact _
    if @explosion
      @explosion.resetSimulation
    else
      init_explosion
    end
  end
end
