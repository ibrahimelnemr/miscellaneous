import file_operations

var
  filename: string = "example.txt"
  content: string = "Hello, Nim Modules!"

file_operations.writeFile(filename, content)

let fileContent = file_operations.readFile(filename)
echo "File Content: ", fileContent
