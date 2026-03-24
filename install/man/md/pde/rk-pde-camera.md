# Processing Camera

- The `camera()` function is similar to `gluLookAt()` in OpenGL.

## Default Camera

This is how the default camera is defined in processing:

```
camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0)
```

The function signature of `camera()`:

```
camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)
```

Breakdown:

- `width/2.0, height/2.0` define the X and Y positions to half the width and height respectively.
- `(height/2.0) / tan(PI*30.0 / 180.0)`: `PI*30.0 / 180.0` converts $30^\circ$ to radians. This is used to achieve a $60^\circ$ field of view at the view plane (which is `(width/2.0,height/2.0,0)`). The tangent calculates the length of the edge of a right triangle representing the viewing plane, two of these triangles is represents the full field of view.

```
  |\
  | \
  |  \
  |   \
  |    \
  |     \
  |      \
  |       \
d |        \ h/2
  |         \
  |          \
  |           \
  |            \
  |             \
  |______________\
      d*tan(30°)
```