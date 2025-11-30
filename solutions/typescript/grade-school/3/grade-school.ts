interface SparseArray<T> {
  [key: number]: T
}

type RosterT = SparseArray<string[]>;

export class GradeSchool {
  #gradeForStudent: { [name: string]: number } = {};

  roster(): RosterT {
    let studentsForGrade = Object.entries(this.#gradeForStudent)
      .reduce((accumulator: RosterT, [name, grade]: [string, number]) => {
        if (!accumulator[grade])
          accumulator[grade] = [];
        accumulator[grade].push(name);
        return accumulator;
      }, {});
    Object.values(studentsForGrade).forEach(names => names.sort());
    return studentsForGrade;
  }

  add(name: string, grade: number): void {
    this.#gradeForStudent[name] = grade;
  }

  grade(n: number): string[] {
    return Object.keys(this.#gradeForStudent)
      .filter(name => this.#gradeForStudent[name] == n)
      .sort();
  }
}
