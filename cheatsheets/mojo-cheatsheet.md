
https://docs.modular.com/mojo/manual/basics.html

# Functions

Functions declared with fn must have argument types and return type defined.

```mojo
fn greet(name: String) -> String:
    return "Hello, " + name + "!"
```

Functions declared with def do not have to have argument types or return type defined.

```mojo
def greet(name):
    return "Hello, " + name + "!"
```

# Variables

```mojo
var x: Int = 1 # x is mutable 
let y: Int = 1 # y is immutable
```

# Value ownership

`inout` signifies a mutable reference
`borrowed` signifies an immutable reference
`owned` signifies pass by value

All values passed to a `def` function are owned by default

All values passed to a `fn` function are borrowed by default

```mojo
fn add(inout x: Int, borrowed y: Int):
    x += y # will change the value of x; x is passed as mutable reference
    y += x # will not change the value of y; y is passed as immutable reference

# This function will modify the value of x as it is passes as a mutable reference

#

```

# Structs


```mojo
struct Person:
    var name: String
    var age: Int

    fn __init__(inout self, name: String,  age: Int):
        self.name = name
        self.age = age

    fn greet(self):
        print("Hello, my name is " + self.name)

def main():
    let john = Person("John", 23)

```

# Traits

Traits are similar to interfaces or protocols in other languages

```mojo
trait SomeTrait:
    fn required_method(self, x: Int): ...
```

```mojo
struct SomeStructThatConformsToTrait:
    fn required_method(self, x: Int):
        print(x)
```