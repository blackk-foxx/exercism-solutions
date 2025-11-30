export class Matrix {
  _rows: number[][];

  constructor(inputText: string) {
    this._rows = inputText.split('\n').map((inputRow: string) =>
      inputRow.split(' ').map((token: string) => +token)
    )
  }

  get rows(): number[][] {
    return this._rows
  }

  get columns(): number[][] {
    let columnCount = this._rows[0].length;
    let columnIndices = [...Array(columnCount).keys()];
    return columnIndices.map((c: number) =>
      this._rows.map((row: number[]) => row[c])
    )
  }
}
