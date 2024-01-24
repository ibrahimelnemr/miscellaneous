# module file_operations

proc readFile*(filename: string): string =
  result = ""
  try:
    let file = open(filename, fmRead)
    result = readAll(file)
    close(file)
  except IOError:
    echo "Error: Could not read the file."

proc writeFile*(filename, content: string) =
  try:
    let file = open(filename, fmWrite)
    write(file, content)
    close(file)
  except IOError:
    echo "Error: Could not write to the file."
