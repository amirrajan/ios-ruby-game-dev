class Arrow
  attr_accessor :node, :x, :y, :floor

  def initialize x, y, vx, vy, floor
    @x = x
    @y = y
    @dx = vx
    @dy = vy
    @floor = floor
  end

  def gravity
    -1
  end

  def bottom_of_arrow
    @floor + 30
  end

  def update
    if(@y > bottom_of_arrow)
      @x += @dx
      @y += @dy
      @dy += gravity
      @y = bottom_of_arrow if @y < bottom_of_arrow
      node.position = CGPointMake(@x, @y)
    else
      node.position = CGPointMake(@x, bottom_of_arrow)
    end
  end

  def create_node parent
    return @node if @node

    @node = add_sprite(parent,
                       @x,
                       @y,
                       'ball.png',
                       'circle')

    @node.physicsBody = SKPhysicsBody.bodyWithCircleOfRadius(20)
    @node.physicsBody.dynamic = true
    @node.physicsBody.categoryBitMask = 2
    @node.physicsBody.contactTestBitMask = 4
    @node.physicsBody.collisionBitMask = 0
  end

  def add_sprite parent, x, y, path, name
    texture = SKTexture.textureWithImageNamed path
    sprite = SKSpriteNode.spriteNodeWithTexture texture
    sprite.position = CGPointMake x, y
    sprite.name = name
    parent.addChild sprite
    sprite
  end
end
