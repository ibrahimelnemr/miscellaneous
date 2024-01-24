# OOP

```nim
type Animal = object
    name: string
    age: int

proc speak(self: Animal, message: string) =
    echo self.name & "says: " & message

var sparky = Animal(name: "Sparky", age: 10)

sparky.speak("Hi")

# is equivalent to
speak(sparky, "Hi")
```

# Modules
```nim
# firstModule.nim

type
    firstType* = int

```



