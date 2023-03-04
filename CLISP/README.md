# CLISP

# L1a (11)

a. Determine the least common multiple of the numerical values of a nonlinear list.

b. Write a function to test if a linear list of numbers has a "mountain" aspect (a list has a "mountain" aspect if the items increase to a certain point and then decreases.

Eg. (10 18 29 17 11 10). The list must have at least 3 atoms to fullfil this criteria.

c. Remove all occurrences of a maximum numerical element from a nonlinear list.

d. Write a function which returns the product of numerical even atoms from a list, to any level.

# L1b (7)

Write recursive Lisp functions for the following problems (optionally, you may use MAP functions):

A binary tree is memorised in the following two ways:

(node no-subtrees list-subtree-1 list-subtree-2 ...) (1)

(node (list-subtree-1) (list-subtree-2) ...) (2)

Return the level of a node X in a tree of type (1). The level of the root element is 0.

# L2 (8)

Write a function to determine the number of nodes on the level k from a n-tree represented as follows: (root list_nodes_subtree1 ... list_nodes_subtreen)

Eg: tree is (a (b (c)) (d) (e (f))) and k=1 => 3 nodes
