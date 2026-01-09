use rand::Rng;
use rand::distr::Alphabetic;
use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

/// A `RobotFactory` is responsible for ensuring that all robots produced by
/// it have a unique name. Robots from different factories can have the same
/// name.
pub struct RobotFactory(Rc<RefCell<NameRegistrar>>);

pub struct NameRegistrar {
    used_names: HashSet<String>
}

pub struct Robot {
    name: String,
    factory: Rc<RefCell<NameRegistrar>>
}

impl RobotFactory {
    pub fn new() -> Self {
        Self(Rc::new(RefCell::new(NameRegistrar {
            used_names: HashSet::new()
         })))
    }

    pub fn new_robot<R: Rng>(&self, rng: &mut R) -> Robot {
        let mut result = Robot { 
            name: String::new(),
            factory: Rc::clone(&self.0)
        };
        result.reset(rng);
        result
    }
}

impl NameRegistrar {
    pub fn try_register(&mut self, name: &str, old_name: &str) -> bool {
        let used_names = &mut self.used_names;
        if used_names.contains(name) {
            return false;
        }
        used_names.insert(name.into());
        used_names.remove(old_name);
        true
    }
}

impl Robot {
    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn reset<R: Rng>(&mut self, rng: &mut R) {
        let old_name = self.name.clone();
        loop {
            let name = Self::get_random_name(rng);
            if self.factory.borrow_mut().try_register(&name, &old_name) {
                self.name = name;
                break;
            }
        }
    }

    fn get_random_name<R: Rng>(rng: &mut R) -> String {
        let (c1, c2) = (Self::get_random_letter(rng), Self::get_random_letter(rng));
        format!("{}{}{:03}", c1, c2, rng.random_range(0..=999))
    }

    fn get_random_letter<R: Rng>(rng: &mut R) -> char {
        rng.sample(Alphabetic) as char
    }
}
