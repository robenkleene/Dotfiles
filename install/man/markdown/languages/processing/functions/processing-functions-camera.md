# Processing Functions Camera

```
camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)
```

- `eyeX, eyeY, eyeZ`: Position of the camera
- `centerX, centerY, centerZ`: Position the camera is pointed at
- `upX, upY, upZ`: Defines the up direction (e.g., `0, 1, 0` is a vector representing the Y axis as up, since the vector just defines a direction `0, 0.1, 0` is identical). This defines the "roll" of the camera, i.e., rotation of the camera. A vector of `0, 0, 0` is invalid and means the camera will not work.
