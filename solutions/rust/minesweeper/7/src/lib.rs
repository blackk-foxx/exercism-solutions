pub fn annotate(minefield: &[&str]) -> Vec<String> {
    Minefield::new(minefield).annotate()
}

struct Minefield<'a> {
    field: &'a[&'a str],
    height: usize,
    width: usize
}

impl Minefield<'_> {
    fn new<'a>(minefield: &'a[&'a str]) -> Minefield {
        Minefield { 
            field: minefield,
            height: minefield.len(),
            width: match minefield.get(0) {
                Some(row) => row.len(),
                None => 0
            }
        }
    }

    fn annotate(&self) -> Vec<String> {
        (0..self.height).map(|r| {
            (0..self.width).map(|c| 
                self.get_annotation(r, c).unwrap()
            ).collect()
        }).collect()
    }

    fn get_annotation(&self, row: usize, col: usize) -> Option<char> {
        self.get_char_at(row as isize, col as isize)
            .and_then(|c| match c {
                '*' => Some('*'),
                ' ' => {
                    let mine_count = self.count_neighboring_mines(row, col);
                    get_mine_count_symbol(mine_count)
                },
                c => panic!("Invalid symbol {c}"),
            }
        )
    }

    fn count_neighboring_mines(&self, row: usize, col: usize) -> usize {
        get_neighborhood_coords(row, col)
            .filter(|(r, c)| self.has_mine(*r, *c))
            .count()
    }

    fn has_mine(&self, r: isize, c: isize) -> bool {
        self.get_char_at(r, c) == Some('*')
    }

    fn get_char_at(&self, r: isize, c: isize) -> Option<char> {
        if r < 0 || c < 0 { return None; }
        let result = self.field.get(r as usize)?.as_bytes().get(c as usize)?;
        Some(*result as char)
    }
}

fn get_mine_count_symbol(mine_count: usize) -> Option<char> {
    match mine_count {
        0 => Some(' '),
        n => char::from_digit(n as u32, 10)
    }
}

fn get_neighborhood_coords(row: usize, col: usize) -> impl Iterator<Item = (isize, isize)> {
    const OFFSETS: [(isize, isize); 8] = [
        (-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)
    ];
    let irow = row as isize;
    let icol = col as isize;
    OFFSETS.into_iter()
        .map(move |(dr, dc)| (irow + dr, icol + dc))
} 
