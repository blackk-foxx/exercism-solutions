use_module(library(pairs)).

create_school(School) :- School = [].

roster(School, Students) :- 
    group_pairs_by_key(School, StudentsForGrade),
    pairs_values(StudentsForGrade, StudentsByGrade),
    flatten(StudentsByGrade, Students).

add_student(School, Student, Grade, NewSchool) :-
    roster(School, Roster),
    \+ member(Student, Roster),
    append(School, [Grade-Student], Unsorted),
    sort(Unsorted, NewSchool).

grade(School, Grade, Students) :-
    group_pairs_by_key(School, StudentsForGrade),
    (member(Grade-Students, StudentsForGrade); Students = []).
