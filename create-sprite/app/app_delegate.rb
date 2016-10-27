class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @game_view_controller = GameViewController.new

    UIApplication.sharedApplication.setIdleTimerDisabled true
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = @game_view_controller
    @window.makeKeyAndVisible

    true
  end
end
