pub type Value = i32;
pub type Result = std::result::Result<(), Error>;

use std::collections::HashMap;

pub struct Forth {
    stack: Vec<i32>,
    definitions: HashMap<String, String>
}

#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    DivisionByZero,
    StackUnderflow,
    UnknownWord,
    InvalidWord,
}

impl Forth {
    pub fn new() -> Self {
        Self {
            stack: Vec::new(),
            definitions: HashMap::new()
        }
    }

    pub fn stack(&self) -> &[Value] {
        &self.stack
    }

    fn push(&mut self, value: i32) {
        self.stack.push(value)
    }

    fn pop(&mut self) -> std::result::Result<i32, Error> {
        self.stack.pop().ok_or(Error::StackUnderflow)
    }

    pub fn eval(&mut self, input: &str) -> Result {
        let mut reading_definition = false;
        let mut definition_tokens: Vec<&str> = Vec::new();
        let normalized_input = input.to_lowercase();
        for token in normalized_input.split(" ") {
            if reading_definition {
                if token == ";" {
                    reading_definition = false;
                    self.add_definition(&definition_tokens)?;
                }
                else {
                    definition_tokens.push(token);
                }
            }
            else if token == ":" {
                reading_definition = true;
                definition_tokens = Vec::new();
            }
            else if let Ok(value) = token.parse::<i32>() {
                self.push(value);
            }
            else if let Some(definition) = self.get_definition(token) {
                self.eval(definition.as_str())?;
            }
            else if Self::is_arithmetic_operator(token) {
                let result = self.perform_arithmetic(token)?;
                self.push(result);
            }
            else {
                self.perform_command(token)?;
            }
        }
        Ok(())
    }

    fn add_definition(&mut self, tokens: &[&str]) -> Result {
        let name = tokens[0];
        if name.parse::<i32>().is_ok() {
            return Err(Error::InvalidWord)
        }
        let mut value = tokens[1..].join(" ");
        if let Some(resolution) = self.definitions.get(name).cloned() {
            self.resolve_existing_refs(name, &resolution);
            value = value.replace(name, &resolution)
        }
        self.definitions.insert(name.into(), value);
        Ok(())
    }

    fn resolve_existing_refs(&mut self, name: &str, resolution: &str) {
        self.definitions.iter_mut().for_each(|(_, existing_value)| {
            *existing_value = existing_value.replace(name, &resolution);
        });
    }

    fn get_definition(&self, name: &str) -> Option<String> {
        self.definitions.get(name).cloned()
    }

    fn is_arithmetic_operator(symbol: &str) -> bool {
        ["+", "-", "*", "/"].iter().any(|&op| op == symbol)
    }

    fn perform_arithmetic(&mut self, operator: &str) -> std::result::Result<i32, Error> {
        let (a, b) = (self.pop()?, self.pop()?);
        match operator {
            "+" => Ok(b + a),
            "-" => Ok(b - a),
            "*" => Ok(b * a),
            "/" => if a != 0 { Ok(b / a) } else { Err(Error::DivisionByZero) },
            _ => Err(Error::UnknownWord)
        }
    }

    fn perform_command(&mut self, command: &str) -> Result {
        match command {
            "dup" => {
                let &value = self.stack.last().ok_or(Error::StackUnderflow)?;
                self.push(value);
            },
            "drop" => self.pop().map(|_| ())?,
            "swap" => {
                let (a, b) = (self.pop()?, self.pop()?);
                self.push(a);
                self.push(b);
            },
            "over" => {
                let &value = self.stack.iter().nth_back(1).ok_or(Error::StackUnderflow)?;
                self.push(value);
            },
            _ => return Err(Error::UnknownWord)
        }
        Ok(())
    }
}
