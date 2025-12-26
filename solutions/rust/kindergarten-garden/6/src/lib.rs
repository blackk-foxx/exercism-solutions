pub fn plants<'a>(diagram: &'a str, student: &str) -> Vec<&'a str> {
    get_student_pos(student).map_or(
        Vec::new(),
        |student_pos| get_plants_at(diagram.split('\n'), student_pos)
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

fn get_plants_at<'a>(rows: impl Iterator<Item = &'a str>, student_pos: usize) -> Vec<&'a str> {
    let base_pos = student_pos * 2;
    rows
        .flat_map(|row| get_plants_in_row(row, base_pos..(base_pos+2)))
        .collect()
}

fn get_plants_in_row(row: &str, range: impl Iterator<Item = usize>) -> impl Iterator<Item = &'static str> {
    range.map(|index| {
        let code = row.chars().nth(index);
        code.map_or("", plant_for_code)
    })
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
