interface StringArrayByNumber {
  [key: number]: string[]
}

export class GradeSchool {
  #gradeForStudent: { [name: string]: number } = {};

  roster(): StringArrayByNumber {
    let result = this.#students_for_grade();
    Object.values(result).forEach(names => names.sort());
    return result;
  }

  #students_for_grade(): StringArrayByNumber {
    let result: StringArrayByNumber = {};
    Object.entries(this.#gradeForStudent)
      .forEach(([name, grade]) => {
        if (!result[grade])
          result[grade] = [];
        result[grade].push(name);
      });
    return result;
  }

  add(name: string, grade: number): void {
    this.#gradeForStudent[name] = grade;
  }

  grade(n: number): string[] {
    let result: string[] = Object.keys(this.#gradeForStudent)
      .filter(name => this.#gradeForStudent[name] == n);
    result.sort();
    return result;
  }
}
