class GameScene < SKScene
  include ScreenSizes

  def didMoveToView view
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    @button_1 = add_sprite( 50, 60, 'button.png', 'button 1')
    @button_2 = add_sprite(190, 60, 'button.png', 'button 2')
    @button_3 = add_sprite(330, 60, 'button.png', 'button 3')
  end

  def touchesBegan touches, withEvent: _
    node = nodeAtPoint(touches.allObjects.first.locationInNode(self))
    case node.name
    when 'button 1'
      particle_1
    when 'button 2'
      particle_2
    when 'button 3'
      particle_3
    end
  end

  def add_sprite x, y, path, name
    texture = SKTexture.textureWithImageNamed path
    sprite = SKSpriteNode.spriteNodeWithTexture texture
    sprite.position = CGPointMake x, y
    sprite.name = name
    addChild sprite
    sprite
  end

  def particle_1
    particle = SKEmitterNode.alloc.init
    particle.setParticleTexture SKTexture.textureWithImageNamed('square.png')
    particle.setNumParticlesToEmit 200
    particle.setParticleBirthRate 450
    particle.setEmissionAngleRange 360
    particle.setParticleSpeed 1000
    particle.setParticleLifetimeRange 0.5
    particle.setParticleAlphaSpeed(-0.5)
    particle.setPosition CGPointMake(device_screen_width.fdiv(2), device_screen_height.fdiv(2))
    particle.setParticleRotation 0.1
    particle.setParticleRotationRange 6
    particle.setParticlePositionRange CGVectorMake(10, 10)
    particle.setParticleBlendMode SKBlendModeAlpha
    addChild particle
  end

  def particle_2
    particle = SKEmitterNode.alloc.init
    particle.setParticleTexture SKTexture.textureWithImageNamed('square.png')
    particle.setNumParticlesToEmit 200
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
    addChild particle
  end

  def particle_3
    particle = SKEmitterNode.alloc.init
    particle.setParticleTexture SKTexture.textureWithImageNamed('square.png')
    particle.setNumParticlesToEmit 100
    particle.particleBirthRate = 20
    particle.particleLifetime = 3
    particle.emissionAngle = 3.14159 / 2.0
    particle.emissionAngleRange = 3.14159 / 3.0
    particle.particleSpeed = 90
    particle.yAcceleration = -70
    particle.particleAlphaSpeed = -0.3
    particle.setPosition CGPointMake(device_screen_width.fdiv(2), device_screen_height.fdiv(2))
    particle.setParticlePositionRange(CGVectorMake(10, 10))
    particle.particleBlendMode = SKBlendModeAlpha
    addChild particle
  end

  def update currentTime
  end
end
