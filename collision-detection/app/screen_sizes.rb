module ScreenSizes
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
