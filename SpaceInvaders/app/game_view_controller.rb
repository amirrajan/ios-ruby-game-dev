class GameViewController < UIViewController
  def viewDidLoad
    super
    @sk_view = SKView.alloc.initWithFrame CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)
    self.view = @sk_view
    @scene = GameScene.sceneWithSize(@sk_view.frame.size)
    @sk_view.presentScene @scene
  end
end
