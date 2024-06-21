`println` prints with a new line at the end:

``` java
println("value = ", value);
```
`print` does not print a new line:

``` java
print("value = ", value, "\n");
```

## Array

`printArray` is used to print arrays:

``` java
println("arr");
printArray(arr);
print("\n");
```

## Box

Print vertices coordinates.

``` java

void draw() {
  box(cubeSize);
  printBoxVertices(cubeSize);
}

void printBoxVertices(float size) {
  float hs = size / 2.0;

  PVector[] vertices = new PVector[8];
  vertices[0] = new PVector(-hs, -hs, -hs);
  vertices[1] = new PVector( hs, -hs, -hs);
  vertices[2] = new PVector( hs,  hs, -hs);
  vertices[3] = new PVector(-hs,  hs, -hs);
  vertices[4] = new PVector(-hs, -hs,  hs);
  vertices[5] = new PVector( hs, -hs,  hs);
  vertices[6] = new PVector( hs,  hs,  hs);
  vertices[7] = new PVector(-hs,  hs,  hs);

  for (int i = 0; i < vertices.length; i++) {
    PVector v = vertices[i];
    float tx = modelX(v.x, v.y, v.z);
    float ty = modelY(v.x, v.y, v.z);
    float tz = modelZ(v.x, v.y, v.z);
    println("Vertex " + i + ": (" + tx + ", " + ty + ", " + tz + ")");
  }
}
```
