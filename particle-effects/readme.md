This sample app shows how to create assorted particle effects programmatically.

To run the application:

`rake` will run the app in the iPhone 6 simulator.

Here's what it looks like:

<p align="center" style="border: solid 1px silver;">
  <img src="particle-effects.gif" width="200px" />
</p>

High level project structure:

- There are three buttons sprites at the bottom. When each one is
  tapped a differt particle effect is created via an `SKEmitterNode`.
