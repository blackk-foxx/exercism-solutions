export class Matrix {
  private _rows: number[][];

  constructor(inputText: string) {
    this._rows = inputText.split('\n').map((inputRow: string) =>
      inputRow.split(' ').map((token: string) => +token)
    )
  }

  get rows(): number[][] {
    return this._rows
  }

  get columns(): number[][] {
    return this._rows[0].map((_, c: number) => 
      this._rows.map((row: number[]) => row[c])
    );
  }
}
