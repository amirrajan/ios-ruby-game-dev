class GameScene < SKScene
  def didMoveToView view
    self.scaleMode = SKSceneScaleModeAspectFit
    self.backgroundColor = UIColor.whiteColor
    @time_label = add_label(10, 10)
  end

  def add_label x, y
    label = SKLabelNode.labelNodeWithText '0'
    label.position = CGPointMake(x, y)
    label.fontColor = UIColor.blackColor
    label.fontSize = 15
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter
    label.zPosition = 100
    label.fontName = 'Courier New'
    addChild label
    label
  end

  def update currentTime
    @time_label.text = "#{currentTime}"
  end
end
