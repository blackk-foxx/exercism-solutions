pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    match (get_student_pos(student), split_rows(diagram)) {
        (Some(student_pos), Some(rows)) =>
            get_plants_at(rows, student_pos),
        _ => Vec::new()
    }
}

fn split_rows(diagram: &str) -> Option<(&str, &str)> { 
    diagram.split_once('\n')
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

fn get_plants_at(rows: (&str, &str), student_pos: usize) -> Vec<&'static str> {
    let base_pos = student_pos * 2;
    [rows.0, rows.1]
        .into_iter()
        .flat_map(|row| {
            (base_pos..(base_pos + 2)).map(|index| {
                let code = row.chars().nth(index);
                code.map_or("", plant_for_code)
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
