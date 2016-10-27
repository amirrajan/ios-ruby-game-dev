class GameViewController < UIViewController
  def viewDidLoad
    super

    self.view = sk_view

    @scene = GameScene.sceneWithSize(sk_view.frame.size)
    sk_view.presentScene @scene
  end

  def sk_view
    @sk_view ||= SKView.alloc.initWithFrame screen_rect
  end

  def prefersStatusBarHidden
    true
  end

  def device_screen_width
    UIScreen.mainScreen.bounds.size.width
  end

  def device_screen_height
    UIScreen.mainScreen.bounds.size.height
  end

  def screen_rect
    CGRectMake(0, 0, device_screen_width, device_screen_height)
  end
end
