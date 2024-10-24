#include <iostream>

struct MyStruct {
    int data;
};

class MyClass {
private:
    MyStruct& value;  // Reference to MyStruct, which can't be null

public:
    // Constructor initializes the reference
    MyClass(MyStruct& v) : value(v) {}

    // Public getter that returns a reference to the struct
    MyStruct& getValue() {
        return value;
    }
};

int main() {
    MyStruct myStruct = {10};   // Create a struct instance
    MyClass obj(myStruct);      // Pass the reference to the class

    // Access the struct using the getter
    std::cout << "Initial value: " << obj.getValue().data << std::endl;

    // Modify the struct via the reference
    obj.getValue().data = 20;
    std::cout << "Modified value: " << obj.getValue().data << std::endl;

    return 0;
}