# Create Sprite at Point Touched

This sample app shows how to create sprites at touch locations.

To run the application:

`rake` will run the app in the iPhone 6 simulator.

Here's what it looks like:

<p align="center" style="border: solid 1px silver;">
  <img src="touch-event.gif" width="200px" />
</p>

High level structure:

- In the `didMoveToView` method, `view.multipleTouchEnabled` is set to
  `true`.
- Whenever a touch occurs the `touchesBegan` method is invoked.
- The `touches.allObjects` is enumerated to create a sprite at each
  touch location.
- Each sprite is enumerated within the `update` method to get rotated
  via the `zRotation` property.
