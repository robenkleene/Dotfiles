# Processing 3D template

``` java
// Life Cycle

void setup() {
  size(400, 400, P3D);
  noLoop();
}

void draw() {
  camera(800, -200, 0, 0, -200, 0, 0, 1, 0);
  background(200);
  drawGrid(800, 40);
  drawAxes(400);
}

// Custom

void drawAxes(float length) {
  stroke(255, 0, 0);
  line(0, 0, 0, length, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, -length, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, length);
}

void drawGrid(float size, float step) {
  stroke(150);
  strokeWeight(1);
  for (float z = -size/2; z <= size/2; z += step) {
    line(-size/2, 0, z, size/2, 0, z);
  }
  for (float x = -size/2; x <= size/2; x += step) {
    line(x, 0, -size/2, x, 0, size/2);
  }
}
```

# Processing print variable

``` java
println("$1 = ", ${1:result});
```

# Processing print array

``` java
println("$1");
printArray(${1:result});
print("\n");
```

