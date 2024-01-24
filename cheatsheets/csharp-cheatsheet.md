[Codecademy Cheatsheet - Csharp](https://www.codecademy.com/learn/learn-c-sharp/modules/csharp-hello-world/cheatsheet)

# Hello World

```csharp
Console.WriteLine("Enter your name");
name = Console.ReadLine();
```

# String methods

```csharp
string str2="This is a C# Program";
string upperstr2 = str2.ToUpper;
string lowerstr2 = str2.ToLower;
```

```csharp
string str = "Divyesh";
int index1 = str.IndexOf("s");
```

```csharp
string value = "Dot Net Perls";
char first = value[0];
char second = value[1];
char last = value[value.Length - 1];
```

```csharp
string myString = "Divyesh";
string test1 = myString.Substring(2);
```

```csharp
int id  = 100;

string multipliedNumber = $"The multiplied ID is {id * 10}.";

Console.WriteLine(multipliedNumber);
```

# Methods

## Expression body form

Normal form

```csharp
static int Add(int x, int y) { return x + y };
```

Expression-body form
```csharp
static int Add(int x, int y) => x + y;
```

## Lambda expressions

Without using lambda expression
```csharp
int[] numbers = { 3, 10, 4, 6, 8 };
static bool isTen(int n) { return n == 10 };

Array.Exists(numbers, isTen);
```

With lambda expression
```csharp
Array.Exists(numbers, (int n) => {
    return n == 10;
});
```

## Shorter lambda expressions

```csharp
int[] numbers = { 7, 7, 7, 4, 7 };

Array.Find(numbers, (int n) => {
   return n != 7; 
});

Array.Find(numbers, (n) => {return n != 7});

Array.Find(numbers, n => {return n != 7});

Array.Find(numbers, n => n != 7 );

```

## Out parameters

Variables modified in the function will be changed outside of the function.

```csharp
static void GetFavoriteFoods(out string f1, out string f2, out string f3)
{
    f1 = "Sushi";
    f2 = "Pizza";
    f3 = "Hamburgers";
}
```

# Arrays and Loops

```csharp

```