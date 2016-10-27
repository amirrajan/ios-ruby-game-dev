class GameScene < SKScene
  include ScreenSizes

  def didMoveToView view
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    @camera = SKNode.new
    @camera.position = CGPointMake(0, 0)
    addChild @camera
    @button_2 = add_sprite(190, 60, 'button.png', 'button 2')
    particle_2
  end

  def touchesBegan touches, withEvent: _
    node = nodeAtPoint(touches.allObjects.first.locationInNode(self))
    case node.name
    when 'button 2'
      shake
    end
  end

  def add_sprite x, y, path, name
    texture = SKTexture.textureWithImageNamed path
    sprite = SKSpriteNode.spriteNodeWithTexture texture
    sprite.position = CGPointMake x, y
    sprite.name = name
    @camera.addChild sprite
    sprite
  end

  def shake
    randomActions = []
    direction_x = 1
    direction = [1, -1]
    how_many = 10
    max_distance = 100
    duration = 0.25

    how_many.times do |i|
      from = max_distance - (max_distance.fdiv(how_many) * i)
      to = from + 10
      randX = @camera.position.x + (rand(from..to) * direction_x)
      randY = @camera.position.y + (rand(from..to) * direction.sample)
      action = SKAction.moveTo(CGPointMake(randX, randY), duration: (duration).fdiv(how_many))
      randomActions << action
      direction_x *= -1
    end

    randomActions << SKAction.moveTo(CGPointMake(0, 0), duration: (duration).fdiv(how_many))

    rep = SKAction.sequence(randomActions)

    @camera.runAction(rep)
  end

  def particle_2
    particle = SKEmitterNode.alloc.init
    particle.setParticleTexture SKTexture.textureWithImageNamed('square.png')
    particle.setParticleBirthRate 50
    particle.setEmissionAngleRange 360
    particle.setParticleSpeed 30
    particle.setParticleLifetime 10
    particle.setParticleLifetimeRange 20
    particle.setParticleAlphaSpeed(-0.5)
    particle.setPosition CGPointMake(device_screen_width.fdiv(2), device_screen_height.fdiv(2))
    particle.setParticleRotation 0.1
    particle.setParticleRotationRange 6
    particle.setParticlePositionRange CGVectorMake(120, 120)
    particle.setParticleBlendMode SKBlendModeAlpha
    @camera.addChild particle
  end

  def update currentTime
  end
end
