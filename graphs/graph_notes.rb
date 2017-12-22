=begin

Graphs:

VOCAB:

Definition:

  Ordered pair of a set V of vertices and set E of edges.
  Set of vertixes and set of edges

Types of graphs:

  1) Directed => A is Connected to B does not
  imply B is connected to A
  eg. Web crawling, streets in cities with one way streets.

  2) Undirected => If A is connected to be
  then B is connected to A.
  eg. Social Network

Weighted Graph:
  1)Graph wherein each edge has a weight attached to them.

Trees:
  1) Acyclic Connected Graph

Simple Graph:
  1)No Self Loops and no Multiple Edges
  2)Max for undirected: (n(n-1))/2 OR
    MAX for directed = n(n-1)

Dense vs. Sparse:
Dense: Too many edges
Sparse: Too few edges

Self Loop
  1)Node that loops to itself
    eg. Page can link to itself.

MultiEdge
  1)Two vertexes have more than one edge between them, going
    in the same direction
    eg. Flight Patterns.

Path:
1) Sequence of vertices where each adjacent pair is
  connected by an edge.

Simple Path ** most common **
1) Simple path if no vertices or edges are repeated

Trail
1)A walk in which no edges are repeated
  but vertexes can be repeated.


CONNECTED and STRONGLY CONNECTED
1) Strongly Connected: If there is a path from any vertex to any other vertex.
  **Most common for directed graphs**

2) Connected: Undirected Graph that is connected

3) Wealky connected: If we turn a directed graph into an undirected graph
  and it is connected it is wealky conneted.

Cycle:
  1) Starts and ends at the same vertex, and the length of the
    walk must be greater than 0:

Simple Cycle: no repitition other than the start and end
Acyclic Graph: A graph with no cycles!

** IMPLEMENTATION DETAILS ** :

1) Edge List

Simplest thing:

1) Create list of Vertexes and list of edges.

What about a weighted graph?

class Edge

  def initialize(start_vertex, end_vertex, weight = 1)
    @start_vertex = start_vertex
    @end_vertex = end_vertex
    @weight = weight
  end

end

Time and Space complexity analysis:

Memory Usage: O(|V| + |E|)
  This is GREAT -- we can't do too much better without
    tampering with the definition of graphs.

Time Complexity:

1) Find all nodes adjacent to a given node.
  O(|E|) => Because you have to go through the entire
    list of the edges.
  NOT GOOD => We can have |V|^2 edges

2) Find if two given nodes are connected
  O(|E|) => Worst case you have to go through all the
    edges in the list
  NOT GOOD => We can have |V|^2 edges

2) Adjacency Matrix:

Store Edges in a two dimensional array of edges

  0 1 2 3 4 5 6 7 8
0 1 0 1 0 1 1 1 1 1
1
2
3
4
5
6
7
8

NB:Set the space as 1 if there is an edge from i to j,
  and 0 otherwise!
Memory Usage: O(|V^2|)
Time Complexity:

1) Finding Adjacent nodes
  a) Merely go to that row in the matrix and find the 1s
    O(|V|)

2)Find if two given nodes are connected
  a) O(1) -> Just go to the appropriate intersection.

3) Insertion of new Edge
  a) O(1) => Just switch that specific cell.

NB: We can either be given an index or the name of the
  vertex. We can use a hash table to store these key value pairs.
  a hash table of key value

What about a weighted graph?
  1) Instead of 0 and 1, we can fill in the edge weight OR
    an arbitrary value such as INFINITY, -INFINITY, nil, etc.,

When to use?
  a) If graph is dense then we should use it, because the number
    of vertexes will be close to V^2

  b) If graph is sparse, then we should not use it.

EG: Social networks aren't great for this

3) Adjacency List:
  a) Take out the zeroes in our matrix!

  -> Can be pointing to an array,
    a set, a binary tree,
    a linked list, etc.,

{
  A: {B, C, D},
  B: {A, E, F},
  E: {B, H},
  D: {A, H},
}

Space: O(E)

Time:

1) Finding if two nodes are connected
  a) O(|V|) worst case if you are fulfilling a linear search.
  b) But what if it points to a set ??

2)Finding all connected noes
  a) O(|V|) worst case if you are fulfilling a linear search

3) Insertion of new Edge
  a) Depends on the implementation of collection of edges.

** ALGORITHM **
Topological Sorting:

A -> B -> C -> D -> E
Sorted: [A, B, C, D, E]

Definition:
We can only visit a vertex after all the vertexes
  that lead up to it have been visited.


Toposort only works on Directed Acyclic Graphs

Why?

  1) Acyclic: Cyclic graphs, in a cycle, we can never
    choose any vertex that cannot lead up to it.
    Cyclic dependency that can never be resolved

  2) Directed: If we replace every undirected edge with
    a directed edge, then we have cycles.

Topological Sorting's are NOT unique

Why? Definition of topological sorting is lenient.

Every directed acyclic graph,
  there must be a topological sorting

How to check if there is a unique topological sorting?
  If it lies among a hamiltonian path
    (i.e. visits every node exactly once)
    Then it does have a unique path(can be shown like a straight line)

  If it does not, then it does not have unique.

Why?
1) Prerequisites.
2) Downloading packages.


Kahn's algorithm:

Notice...

1) All graphs with no cycles will have nodes without any incoming
  edges it is safe to pick!

a) Result = []
b) Next = []

SELECT Vertexes without any incoming edges.
Append vertex to the

1) Select all Vertexes without any incoming edges
2) Add this to the results Array and delete the appropriate edges
3) For each vertex attached to E check if they now have zero
  incoming edges add to the queue
4) Repeat!

NB: We can use a stack OR a queue! i.e. DFS vs BFS


Time Complexities:

O(|V|+ |E|)

1) Detect Cycles

A) Kahn's algorithm
  a) Visits nodes with no incoming edges.
    i. However we can never break through and
      enter this cycle
    ii. If we still have edges still in our graph
      this indicates we have a cycle
B) Tarjan's algorithm
  a) We must augment each vertex with a flag
    a) When flag is already set we have already visited it.
  b) First gets marked when we are in the process of being visited
    and then gets unmarked!

Shortest Path Finding:

Breath-First-Search can find the shortest path.

Topo Sort can also find the shortes path: Order of what comes first.
-> Very similar to dijkstra's algorithm
  paths_from_toposort(start)

  By using dijksra's algorithm with topo sorting, we don't have to
    jump around nodes!


=end
