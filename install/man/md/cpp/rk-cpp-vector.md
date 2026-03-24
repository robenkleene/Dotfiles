```
#include <vector>
#include <iostream>
int main() {
  std::vector<int> vec = {1, 2, 3, 4, 5};
  std::cout << "Number of elements in vector: " << vec.size() << std::endl;
  return 0;
}
```

`emplace_back` vs `push_back`:

```
#include <vector>
#include <iostream>
#include <string>
struct Widget {
  std::string name;
  Widget(const std::string& n) : name(n) {
      std::cout << "Constructed Widget: " << name << std::endl;
  }
  Widget(const Widget& other) : name(other.name) {
      std::cout << "Copied Widget: " << name << std::endl;
  }
  Widget(Widget&& other) noexcept : name(std::move(other.name)) {
      std::cout << "Moved Widget: " << name << std::endl;
  }
};
int main() {
  std::vector<Widget> widgets;
  Widget w1("push");
  widgets.push_back(w1); // Calls copy constructor
  widgets.push_back(Widget("push_temp")); // Calls move constructor
  widgets.emplace_back("emplace"); // Constructs in place, no copy/move
  return 0;
}
```
