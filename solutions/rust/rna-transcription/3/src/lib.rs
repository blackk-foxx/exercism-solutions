#[derive(Debug, PartialEq, Eq)]
pub struct Dna {
    nucleotides: String
}

#[derive(Debug, PartialEq, Eq)]
pub struct Rna {
    nucleotides: String
}

fn validate(given: &str, allowed: &str) -> Result<String, usize> {
    let mut result = String::new();
    for (i, c) in given.chars().enumerate() {
        if !allowed.contains(c) {
            return Err(i);
        }
        result.push(c);
    }
    Ok(result)
}

impl Dna {
    pub fn new(dna: &str) -> Result<Dna, usize> {
        Ok(Dna { nucleotides: validate(dna, "ACGT")? })
    }

    pub fn into_rna(self) -> Rna {
        Rna { 
            nucleotides: self.nucleotides
                .chars()
                .map(Self::complement)
                .collect()
        }
    }

    fn complement(n: char) -> char {
        match n {
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
            _ => ' '
        }
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        Ok(Rna { nucleotides: validate(rna, "ACGU")? })
    }
}
