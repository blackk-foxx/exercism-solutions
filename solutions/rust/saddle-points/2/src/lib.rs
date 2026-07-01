pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    let num_rows = input.len();
    let num_cols = input[0].len();
    let max_height_per_row: Vec<u64> = input.iter()
        .filter_map(|row| row.iter().copied().max())
        .collect();
    let min_height_per_col: Vec<u64> = (0..num_cols)
        .filter_map(|c| get_column(input, c).min())
        .collect();
    let mut result = Vec::new();
    for r in 0..num_rows {
        for c in 0..num_cols {
            if input[r][c] == max_height_per_row[r] &&
               input[r][c] == min_height_per_col[c] {
                   result.push((r, c)) 
               }
        }
    }
    result
}

fn get_column(rows: &[Vec<u64>], col_index: usize) -> impl Iterator<Item = u64> {
    rows.iter().map(move |row| row[col_index])
}