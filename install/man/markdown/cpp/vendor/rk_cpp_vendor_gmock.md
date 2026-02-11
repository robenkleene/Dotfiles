# C++ Vendor Google Mock

A mock defined like this `MOCK_METHOD0(GetFoo, Foo&())`, probably needs a corresponding `ON_CALL(*this, GetFoo).WillByDefault(::testing::ReturnRef(*foo))`
