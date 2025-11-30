interface StringArrayByNumber {
  [key: number]: string[]
}

export class GradeSchool {
  _gradeForStudent: { [name: string]: number } = {};

  roster(): StringArrayByNumber {
    let result: StringArrayByNumber = {};
    Object.entries(this._gradeForStudent)
      .forEach(([name, grade]) => {
        if (!result[grade])
          result[grade] = [];
        result[grade].push(name);
      });
    Object.values(result).forEach(names => names.sort());
    return result;
  }

  add(name: string, grade: number): void {
    this._gradeForStudent[name] = grade;
  }

  grade(n: number): string[] {
    let result: string[] = Object.keys(this._gradeForStudent)
      .filter(name => this._gradeForStudent[name] == n);
    result.sort();
    return result;
  }
}
