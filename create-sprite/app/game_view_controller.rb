class GameViewController < UIViewController
  include ScreenSizes

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
end
