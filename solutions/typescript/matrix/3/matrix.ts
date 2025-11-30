export class Matrix {
  #rows: number[][];

  constructor(inputText: string) {
    this.#rows = inputText.split('\n').map((inputRow: string) =>
      inputRow.split(' ').map((token: string) => +token)
    )
  }

  get rows(): number[][] {
    return this.#rows
  }

  get columns(): number[][] {
    return this.#rows[0].map((_, c: number) => 
      this.#rows.map((row: number[]) => row[c])
    );
  }
}
