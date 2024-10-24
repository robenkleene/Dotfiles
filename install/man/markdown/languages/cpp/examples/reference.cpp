#include <iostream>

struct MyStruct {
    int data;
};

class MyClass {
private:
    MyStruct* value;

public:
    MyClass(int v) {
        value = new MyStruct();
        value->data = v;
    }

    ~MyClass() {
        delete value;
    }

    MyStruct& getValue() {
        return *value;
    }
};

int main() {
    MyClass obj(10);

    MyStruct& valRef = obj.getValue();
    std::cout << "Initial value: " << valRef.data << std::endl;

    valRef.data = 20;
    std::cout << "Modified value: " << obj.getValue().data << std::endl;

    return 0;
}
