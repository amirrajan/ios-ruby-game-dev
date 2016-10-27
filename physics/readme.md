# Physics

This sample app shows how to set up a physics body and apply collision
detection.

To run the application:

`rake` will run the app in the iPhone 6 simulator.

Here's what it looks like:

<p align="center" style="border: solid 1px silver;">
  <img src="physics.gif" width="200px" />
</p>

High level structure:

- The `@ball` is given an `SKPhysicsBody`.
- The walls `@wall` and `@wall2` are each given an `SKPhysicsBody`
  with `dynamic` set to false (this ensures that they don't move).
- During the `update` loop, the `@ball` has it's position reset if
  it's `position.y` is off the screen (it is also given a new
  `physicsBody` to remove an carried momentum.
