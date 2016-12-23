class GameScene < SKScene
  include ScreenSizes

  def shoot_arrow vx, vy
    arrow = Arrow.new(20, device_screen_height * 0.8, vx, vy, floor)
    arrow.create_node self
    @arrows << arrow
  end

  def didMoveToView view
    $self = self
    @arrows = []
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    self.physicsWorld.gravity = CGVectorMake(0, 0)
    self.physicsWorld.contactDelegate = self
    self.view.showsPhysics = true

    @wall = add_sprite(device_screen_width.fdiv(2),
                       floor,
                       'wall.png',
                       'wall')
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
    @arrows.each do |a|
      a.update
    end
  end

  def floor
    35
  end

  def touchesBegan touches, withEvent: _
    @begin_touch = touches.allObjects.first.locationInNode(self)
  end

  def touchesEnded touches, withEvent: _
    @end_touch = touches.allObjects.first.locationInNode(self)
    vx = @begin_touch.x - @end_touch.x
    vy  = @begin_touch.y - @end_touch.y
    shoot_arrow(vx * 0.10, vy * 0.10)
  end

  def didBeginContact _
  end
end
