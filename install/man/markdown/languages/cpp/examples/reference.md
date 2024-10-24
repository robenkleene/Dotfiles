# Reference

Illustrates two examples of returning a reference to a member variable, one where that member variable is pointer, the other where it's a reference. The reference is preferable because with the pointer, if the pointer gets set to `nullptr`, we'll be dereferencing a null pointer when accessing the getter. With a reference, it's a compile error to try to set the reference to `nullptr`.
