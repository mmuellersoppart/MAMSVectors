# MAMSVectors

A package that redefines a few Core Graphics types for SwiftUI's canvas.

## Overview

Three types are included.

* ``Point2D`` (`CGPoint`)
* ``Vector2D`` (`CGVector`)
* ``PositionalVector2D`` (a combination of `CGPoint` and `CGVector`)

![OverviewPicture](https://user-images.githubusercontent.com/16762461/164913080-981e64e5-182a-4bb4-8dab-eeebb60da226.png)

Main benefits of this package are

* Basic operators are defined. e.g. `+`, `*`, `==`
* Both Imperative and Functional programming options available for many operations.
* ``Point2D`` and ``PositionalVector2D`` can draw themselves for easy debugging with the ``Drawable`` protocol. 
* Clearly laid out DocC Documentation with example use cases.

