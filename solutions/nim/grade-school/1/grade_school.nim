import std/sequtils
import std/algorithm
  
type
  Student* = object
    name*: string
    grade*: int

  School* = object
    students*: seq[Student]

proc compareStudents(a, b: Student): int =
  result = cmp(a.grade, b.grade)
  if result == 0:
    result = cmp(a.name, b.name)

proc roster*(school: School): seq[string] =
  ## Returns the names of every student in the `school`, sorted by grade then name.
  var students = school.students
  sort(students, compareStudents)
  map(students, proc(x: Student): string = x.name)

proc addStudent*(school: var School, name: string, grade: int) =
  ## Adds a student with `name` and `grade` to the `school`.
  ##
  ## Raises a `ValueError` if `school` already contains a student named `name`.
  if any(school.students, proc(x: Student): bool = x.name == name):
    raise new(ref ValueError)
  school.students.add(Student(name: name, grade: grade))

proc grade*(school: School, grade: int): seq[string] =
  ## Returns the names of the students in the given `school` and `grade`, in
  ## alphabetical order.
  var students = filter(school.students, proc(x: Student): bool = x.grade == grade)
  sort(students, compareStudents)
  map(students, proc(x: Student): string = x.name)
