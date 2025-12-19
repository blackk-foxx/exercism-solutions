pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    match (get_student_pos(student), split_rows(diagram)) {
        (Some(student_pos), Some(rows)) =>
            get_plants_at(rows, student_pos),
        _ => Vec::new()
    }
}

fn split_rows(diagram: &str) -> Option<[&str; 2]> { 
    diagram.chars().position(|c| c == '\n').map(
        |newline_pos| { 
            let row1 = diagram; 
            let row2 = &diagram[(newline_pos + 1)..]; 
            [row1, row2]
        }
    ) 
}

fn get_student_pos(student: &str) -> Option<usize> {
    let students = [
        "Alice",
        "Bob",
        "Charlie",
        "David",
        "Eve",
        "Fred",
        "Ginny",
        "Harriet",
        "Ileana",
        "Joseph",
        "Kincaid",
        "Larry"
    ];
    students.iter().position(|&s| s == student)
}

fn get_plants_at(rows: [&str; 2], student_pos: usize) -> Vec<&'static str> {
    rows
        .into_iter()
        .flat_map(|row| {
            (0..2).map(|column_index| {
                let index = student_pos * 2 + column_index;
                let code = row.chars().nth(index);
                code.map_or("", |code| plant_for_code(code))
            })
        })
        .collect()
}

fn plant_for_code(code: char) -> &'static str {
    match code {
        'C' => "clover",
        'G' => "grass",
        'R' => "radishes",
        'V' => "violets",
        _ => ""
    }
}
