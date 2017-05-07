class GameScene < SKScene
  BULLET_SPEED = 2.5
  BOOST_POWER = 0.95
  BOOST_DRAG_PERCENTAGE = 0.95
  WORLD_WIDTH = UIScreen.mainScreen.bounds.size.width
  WORLD_HEIGHT = UIScreen.mainScreen.bounds.size.height
  SHIP_SIZE = WORLD_WIDTH.fdiv(14)
  BULLET_SIZE = SHIP_SIZE.fdiv(2)
  ENEMY_MOVEMENT_SPACE = 7
  PLAYER_SHIP_ENEMY_BULLET_CATEGORY = 2
  ENEMY_SHIP_PLAYER_BULLET_CATEGORY = 4
  PLAYER_Y_POSITION = 150
  INSTRUCTIONS_FONT = 17

  def didMoveToView view
    $self = self
    self.scaleMode = SKSceneScaleModeAspectFit
    physicsWorld.gravity = CGVectorMake 0, 0
    physicsWorld.contactDelegate = self
    @live_canvas = SKNode.new
    @dead_canvas = SKNode.new
    addChild @live_canvas
    addChild @dead_canvas
    @bullets = []
    @enemies = []
    @score_label = add_label '', WORLD_WIDTH.fdiv(2), WORLD_HEIGHT.fdiv(2), 100
    @instructions_label_one = add_label 'Tap hereish to move right.',
                                        WORLD_WIDTH - WORLD_WIDTH.fdiv(4),
                                        PLAYER_Y_POSITION.fdiv(2),
                                        INSTRUCTIONS_FONT
    @instructions_label_two = add_label 'Tap hereish to move left.',
                                        WORLD_WIDTH.fdiv(4),
                                        PLAYER_Y_POSITION.fdiv(2),
                                        INSTRUCTIONS_FONT
    @instructions_label_three = add_label 'Tap anywhere ABOVE the ship to shoot.',
                                          WORLD_WIDTH.fdiv(2),
                                          PLAYER_Y_POSITION + SHIP_SIZE * 1.5,
                                          INSTRUCTIONS_FONT
    @ship = add_sprite 'ship', 0, 0, SHIP_SIZE, PLAYER_SHIP_ENEMY_BULLET_CATEGORY
    reset_game
  end

  def reset_game
    @dx = 0
    @hide_instructions = false
    @instructions_label_one.alpha =
      @instructions_label_two.alpha =
      @instructions_label_three.alpha = 1
    @ship.position = CGPointMake WORLD_WIDTH.fdiv(2), PLAYER_Y_POSITION
    reset_enemies
    @time_between_enemy_bullets = 600
    @bullets.each(&:removeFromParent)
    @bullets.clear
    @ship_bullet && @ship_bullet.removeFromParent
    @ship_bullet = nil
    flash_score 0
  end

  def reset_enemies
    @enemies.each(&:removeFromParent)
    @enemies = (0..3).to_a.product((0..6).to_a).map do |tuple|
      row, column = tuple
      add_sprite 'enemy',
                 (column * SHIP_SIZE) + SHIP_SIZE.fdiv(2),
                 WORLD_HEIGHT - (row * SHIP_SIZE) - SHIP_SIZE.fdiv(2) - 40,
                 SHIP_SIZE,
                 ENEMY_SHIP_PLAYER_BULLET_CATEGORY
    end

    @movement_direction = 1
    @move_movement_direction_tick = ENEMY_MOVEMENT_SPACE
  end

  def add_sprite name, x, y, size, collision_category
    sprite = SKSpriteNode.spriteNodeWithTexture SKTexture.textureWithImageNamed('square.png')
    sprite.name = name
    sprite.position = CGPointMake x, y
    scale = size.fdiv(sprite.size.width)
    sprite.xScale = sprite.yScale = scale
    sprite.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize sprite.size
    sprite.physicsBody.collisionBitMask = 0
    sprite.physicsBody.categoryBitMask = collision_category
    sprite.physicsBody.contactTestBitMask = collision_category
    sprite.alpha = 0
    @live_canvas.addChild sprite
    sprite
  end

  def add_label text, x, y, font_size
    label = SKLabelNode.labelNodeWithText text
    label.position = CGPointMake(x, y)
    label.fontSize = font_size
    addChild label
    label
  end

  def update _
    fade_in_fade_out_labels
    fade_in_fade_out_sprites
    move_enemies
    generate_bullet
    move_bullets
    move_ship
    reset_enemies if @enemies.length.zero?
  end

  def fade_in_fade_out_labels
    @score_label.alpha -= 0.1 if @score_label.alpha > 0
    @instructions_label_one.alpha -= rand.fdiv(5) if @instructions_label_one.alpha > 0 && @hide_instructions
    @instructions_label_two.alpha -= rand.fdiv(5) if @instructions_label_two.alpha > 0 && @hide_instructions
    @instructions_label_three.alpha -= rand.fdiv(5) if @instructions_label_three.alpha > 0 && @hide_instructions
  end

  def fade_in_fade_out_sprites
    @live_canvas.children.find_all { |c| c.alpha < 1 }.each { |c| c.alpha += rand.fdiv(5) }
    @dead_canvas.children.find_all { |c| c.alpha > 0 }.each { |c| c.alpha -= rand.fdiv(5) }
    @dead_canvas.children.find_all { |c| c.alpha <= 0 }.each(&:removeFromParent)
  end

  def move_ship
    @ship.position = CGPointMake(@ship.position.x + @dx, @ship.position.y)

    if @ship.position.x - SHIP_SIZE.fdiv(2) < 0
      @ship.position = CGPointMake SHIP_SIZE.fdiv(2), @ship.position.y
      @dx = 0
    end

    if @ship.position.x + SHIP_SIZE.fdiv(2) > WORLD_WIDTH
      @ship.position = CGPointMake WORLD_WIDTH - SHIP_SIZE.fdiv(2), @ship.position.y
      @dx = 0
    end

    @dx *= BOOST_DRAG_PERCENTAGE

    @boost_direction && @dx += BOOST_POWER * @boost_direction
  end

  def touchesBegan touches, withEvent: _
    @hide_instructions = true
    first_touch = touches.allObjects.first.locationInNode(self)
    if first_touch.y < PLAYER_Y_POSITION
      @boost_direction = 1
      @boost_direction = -1 if first_touch.x < WORLD_WIDTH.fdiv(2)
    elsif !@ship_bullet
      @ship_bullet = add_sprite 'ship_bullet',
                                @ship.position.x,
                                @ship.position.y + SHIP_SIZE.fdiv(2),
                                BULLET_SIZE,
                                ENEMY_SHIP_PLAYER_BULLET_CATEGORY
    else
      @instructions_label_three.text = 'You can only shoot one bullet at a time. Wait.'
      @instructions_label_three.alpha = 10
    end
  end

  def touchesEnded touches, withEvent: _
    @boost_direction = nil
  end

  def move_bullets
    @bullets.each { |b| b.position = CGPointMake(b.position.x, b.position.y - BULLET_SPEED) }
    bullets_to_remove = @bullets.find_all { |b| b.position.y + BULLET_SIZE < 0 }
    bullets_to_remove.each(&:removeFromParent)
    @bullets -= bullets_to_remove
    return unless @ship_bullet
    @ship_bullet.position = CGPointMake(@ship_bullet.position.x, @ship_bullet.position.y + BULLET_SPEED)
    return unless @ship_bullet.position.y > WORLD_HEIGHT
    @ship_bullet.removeFromParent
    @ship_bullet = nil
  end

  def generate_bullet
    @fire_tick_count ||= rand(@time_between_enemy_bullets) + 10
    @fire_tick_count -= 1
    return unless @fire_tick_count <= 0
    @fire_tick_count = nil
    return if @bullets.count >= @enemies.count
    random_enemy = @enemies.sample
    @bullets << add_sprite('enemy_bullet',
                           random_enemy.position.x,
                           random_enemy.position.y - SHIP_SIZE.fdiv(2) - BULLET_SIZE.fdiv(2),
                           BULLET_SIZE,
                           PLAYER_SHIP_ENEMY_BULLET_CATEGORY)
  end

  def move_enemies
    @move_unit_tick_count ||= 60
    @move_unit_tick_count -= 1
    return unless @move_unit_tick_count <= 0
    @enemies.each do |e|
      e.position = CGPointMake(e.position.x + SHIP_SIZE * @movement_direction, e.position.y)
    end
    @move_movement_direction_tick -= 1
    @move_unit_tick_count = nil
    return if @move_movement_direction_tick > 0
    @move_movement_direction_tick = ENEMY_MOVEMENT_SPACE
    @movement_direction *= -1
  end

  def flash_score score
    @score = score
    @score_label.text = @score.to_s
    @score_label.alpha = 10
  end

  def didBeginContact contact
    return if !contact.bodyA.node || !contact.bodyB.node
    if contact.bodyA.node.name == 'ship_bullet' || contact.bodyB.node.name == 'ship_bullet'
      [contact.bodyA.node, contact.bodyB.node].each do |n|
        n.removeFromParent
        @dead_canvas.addChild n
        @enemies -= [n]
        n.physicsBody = nil
      end
      flash_score(@score += 1)
      @time_between_enemy_bullets *= 0.95
      @time_between_enemy_bullets = @time_between_enemy_bullets.floor
      @ship_bullet = nil
    elsif contact.bodyA.node.name == 'ship' || contact.bodyB.node.name == 'ship'
      reset_game
    end
  end
end
