pub mod graph {

    use std::collections::HashMap;
    
    pub mod graph_items {

        pub mod edge {

            use crate::graph::HashMap;
            use crate::graph::get_attr;
            use crate::graph::to_hashmap;

            #[derive(Clone)]
            #[derive(Debug)]
            #[derive(PartialEq)]
            pub struct Edge {
                source: String,
                dest: String,
                attrs: HashMap<String, String>,
            }

            impl Edge {
                pub fn new(source: &str, dest: &str) -> Self {
                    Edge {
                        source: source.into(),
                        dest: dest.into(),
                        attrs: HashMap::new()
                    }
                }

                pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
                    self.attrs = to_hashmap(attrs);
                    self
                }
    
                pub fn attr(&self, name: &str) -> Option<&str> {
                    get_attr(&self.attrs, name)
                }
            }
        }

        pub mod node {

            use crate::graph::HashMap;
            use crate::graph::get_attr;
            use crate::graph::to_hashmap;

            #[derive(Clone)]
            #[derive(Debug)]
            #[derive(PartialEq)]
            pub struct Node {
                label: String,
                attrs: HashMap<String, String>,
            }

            impl Node {
                pub fn new(label: &str) -> Self {
                    Node {
                        label: label.into(),
                        attrs: HashMap::new()
                    }
                }

                pub fn label(&self) -> &str {
                    self.label.as_str()
                }

                pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
                    self.attrs = to_hashmap(attrs);
                    self
                }

                pub fn attr(&self, name: &str) -> Option<&str> {
                    get_attr(&self.attrs, name)
                }
            }
        }
    }

    use graph_items::edge::Edge;
    use graph_items::node::Node;

    pub struct Graph {
        pub edges: Vec::<Edge>,
        pub nodes: Vec::<Node>,
        pub attrs: HashMap<String, String>,
    }

    impl Graph {
        pub fn new() -> Self {
            Graph {
                edges: Vec::new(),
                nodes: Vec::new(),
                attrs: HashMap::new(),
            }
        }

        pub fn with_nodes(mut self, nodes: &[Node]) -> Self {
            self.nodes = nodes.to_vec();
            self
        }

        pub fn with_edges(mut self, edges: &[Edge]) -> Self {
            self.edges = edges.to_vec();
            self
        }

        pub fn with_attrs(mut self, attrs: &[(&str, &str)]) -> Self {
            self.attrs = to_hashmap(attrs);
            self
        }

        pub fn node(&self, label: &str) -> Option<&Node> {
            self.nodes.iter().find(|n| n.label() == label)
        }
    }

    fn get_attr<'a>(attrs: &'a HashMap<String, String>, name: &str) -> Option<&'a str> {
        attrs.get(name).map(|x| x.as_str())
    }

    fn to_hashmap(attrs: &[(&str, &str)]) -> HashMap<String, String> {
        attrs
            .iter()
            .map(|&(k, v)| (k.into(), v.into()))
            .collect()
    }
}
