export class Robot {

  _name: string = "";
  static _usedNames: Set<string> = new Set();

  constructor() {
    this.resetName();
  }

  public get name(): string {
    return this._name;
  }

  public resetName(): void {
    var name: string;
    do {
      name = Robot.generateName();
    } while (Robot._usedNames.has(name));
    Robot._usedNames.add(name);
    this._name = name;
  }

  static generateName(): string {
    return randomLetter() + randomLetter() + randomNumber(100, 999);
  }

  public static releaseNames(): void {
    Robot._usedNames.clear();
  }
}

function randomLetter(): string {
  return String.fromCharCode(randomNumber(0, 25) + "A".charCodeAt(0));
}

function randomNumber(lowerLimit: number, upperLimit: number): number {
  return Math.floor(Math.random() * (upperLimit + 1 - lowerLimit)) + lowerLimit;
}