use std::borrow::Cow;

#[derive(Debug, PartialEq, Eq)]
pub struct Dna<'a> {
    nucleotides: &'a str
}

#[derive(Debug, PartialEq, Eq)]
pub struct Rna<'a> {
    nucleotides: Cow<'a, str>
}

fn validate<'a>(given: &'a str, allowed: &[u8; 4]) -> Result<&'a str, usize> {
    for (i, b) in given.bytes().enumerate() {
        if !allowed.contains(&b) {
            return Err(i);
        }
    }
    Ok(given)
}

impl<'a> Dna<'a> {
    pub fn new(dna: &'a str) -> Result<Dna<'a>, usize> {
        Ok(Dna { nucleotides: validate(dna, b"ACGT")? })
    }

    pub fn into_rna(self) -> Rna<'a> {
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

impl<'a> Rna<'a> {
    pub fn new(rna: &'a str) -> Result<Rna<'a>, usize> {
        Ok(Rna { nucleotides: Cow::Borrowed(validate(rna, b"ACGU")?) })
    }
}
