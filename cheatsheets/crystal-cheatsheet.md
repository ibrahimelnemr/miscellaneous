# Variables and Types

```crystal
message : String = "Hello"

nilvalue: Nil = nil

active: Bool = false

num: Int32 = 16

num2: Float32 = 7.0

letter: Char = 'a'

```

# Methods

Overloading
```crystal
def say_hello(recipient : String)
  puts "Hello #{recipient}!"
end
```
```crystal
def say_hello(times : Int32)
  puts "Hello " * times
end
```

Returning a value

```crystal
def adds_2(n: Int32)
    n + 2
end
```

# Modules

```crystal
module Curses
    class Window
    end
end

Curses::Window.new

```

# Classes

## Class methods

Not a class method
```crystal
module CaesarCipher
    def self.encrypt(string: String)
        string.chars.map { |char|
            ((char.upcase.ord - 52) % 26 + 65).chr
        }.join
    end
end

CaesarCipher.encrypt("HElLO")
```

Class method - method name prefixed with class name and period
```crystal
def CaesarCipher.decrypt(string: String)
    encrypt(string)
end

```