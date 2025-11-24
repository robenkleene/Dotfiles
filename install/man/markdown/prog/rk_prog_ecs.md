# Programming ECS

ECS is an implementation of data-orientated programming. This means the design of the architecture has empathy about how the CPU works.

In Object-Orientated programming:

```
class Player : public GameObject {
  float position[3];
  float velocity[3];
  int health;
  // ...methods...
};
std::vector<Player> players;
```

```
struct Position { float x, y, z; };
struct Velocity { float vx, vy, vz; };
struct Health { int value; };
std::vector<Position> positions;
std::vector<Velocity> velocities;
std::vector<Health> healths;
// Systems process all positions, velocities, or healths in tight loops
```

The ECS example is more memory efficient because memory is accessed as contiguous data (i.e., vectors) instead of scattered around memory (OOP member variables). This results in "cache misses" which is the term when data has to be accessed via the heap, instead of from, e.g., the fast the L1/L2 cache on the CPU (when the data is first accessed, that's always considered a cache miss, this is called a "compulsory miss").

ECS also enables parallelism, e.g., multiple entities can be updated on different threads simultaneously.
