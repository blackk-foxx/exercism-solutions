export class Clock {

  minutes: number;
  readonly MINUTES_PER_DAY = 24 * 60;
  
  constructor(hour: number, minute?: number) {
    let minutes = (hour * 60 + (minute || 0)) % this.MINUTES_PER_DAY;
    let rollover = minutes < 0 ? this.MINUTES_PER_DAY : 0;
    this.minutes = minutes + rollover;
  }

  public toString(): string {
    let hour = Math.trunc(this.minutes / 60);
    let minute = this.minutes % 60;
    return `${this.pad(hour)}:${this.pad(minute)}`;
  }

  pad(n: number): string {
    return n.toString().padStart(2, '0');
  }

  public plus(minutes: number): Clock {
    return new Clock(0, this.minutes + minutes);
  }

  public minus(minutes: number): Clock {
    return new Clock(0, this.minutes - minutes);
  }

  public equals(other: Clock): boolean {
    return this.minutes == other.minutes;
  }
}
