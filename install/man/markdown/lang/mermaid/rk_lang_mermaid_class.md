- The convention of `+` for public methods and `-` for private is from UML

# Subclass

``` mermaid
---
title: Animal example
---
classDiagram
    class Animal {
        +Eat()
        +Sleep()
    }

    class Duck {
        +Quack()
    }

    Duck --|> Animal
```

# Composition

``` mermaid
classDiagram
    class Car {
        -engine: Engine
    }

    class Engine {
        +Start()
    }

    Car --* Engine
```