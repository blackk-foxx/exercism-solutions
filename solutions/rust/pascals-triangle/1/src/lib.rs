use std::iter::once;

pub struct PascalsTriangle {
    row_count: usize
}

impl PascalsTriangle {
    pub fn new(row_count: u32) -> Self {
        Self { row_count: row_count as usize }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        let mut result: Vec<Vec<u32>> = Vec::new();
        if self.row_count > 0 {
            result.push([1].to_vec());
            (1..self.row_count).for_each(|r| {
                let prev_row = &result[result.len() - 1];
                let middle = (1..r).map(|c| prev_row[c - 1] + prev_row[c]);
                let row = once(1).chain(middle).chain(once(1));
                result.push(row.collect());
            });
        }
        result
    }
}
