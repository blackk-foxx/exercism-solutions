use std::collections::BTreeMap;
use std::collections::BTreeSet;

pub struct School<'a> (BTreeMap<&'a str, u32>);

impl<'a> School<'a> {
    pub fn new() -> School<'a> {
        School(BTreeMap::new())
    }

    pub fn add(&mut self, grade: u32, student: &'a str) {
        self.0.entry(student).or_insert(grade);
    }

    pub fn grades(&self) -> Vec<u32> {
        let set: BTreeSet<u32> = self.0.values().cloned().collect();
        set.into_iter().collect()
    }

    // If `grade` returned a reference, `School` would be forced to keep a `Vec<String>`
    // internally to lend out. By returning an owned vector of owned `String`s instead,
    // the internal structure can be completely arbitrary. The tradeoff is that some data
    // must be copied each time `grade` is called.
    pub fn grade(&self, grade: u32) -> Vec<String> {
        self.0
            .iter()
            .filter_map(|(&student, &g)| (g == grade).then_some(student.into()))
            .collect()
    }
}
