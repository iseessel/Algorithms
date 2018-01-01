=begin

Greedy Algorithms:

Repeatedly makes locally best choice/decisions ignoring
  effect on future.

Properties:

1) Optimal substructure: Optimal solution of previous solutions
  can be used to solve the next solution.

2) Greedy-choice property: Locally optimal choice leads to globally
  optimal solution.

Minimum Spanning Tree:

What is a tree?
  Connected Acyclic Graph.

Spanning Tree?
  i.e. sub-graph that should form a tree
  Contains all the vertices **

If the graph is disconnected it is impossible!

MST: Given weighted graph G = (V, E) and edge weights
  W: E -> R

  Find a spanning tree T of minimum total weight!

  Weight = sum of weights of edges.


Optimal Substructure:

if e = {u, v} is an edge of some MST

  Contract Edge; i.e. merge u and v {u, v} => {uv}
    and edge disappears

    If you have mutual edges, then take the minimum of
      those edges.

      x
      -
    u -> v
      -
      y

RECURRENCE:
  If T' is a MST of G/E, then T' U {E} is a MST of G

  i.e. If we contracted an edge the MST of that graph is the
    MST of the contracted graph plus the edge that was contracted.

Proof
  Say MST T* of g contains edge e.
  Let T' = MST of T*/e
  We want to prove T' U { e } is a MST of g.

    => T* - e is a spanning tree of G/e
      NB: Still hits all the vertices.

    => W(T') <= W(T* - e)
    => W(T' U {e}) = W(T') + W(e)
    => W(T') + W(e) <= W(T* - e) + W(e) = W(T*)
    => W(T' U {e}) <= W(T*)

    Therefore W(T' U {e} )is a minimum spanning tree.



Dynamic Programming
  1) Guess edge e in a MST
  2) Contract Edge
  3) Recurse
  4) Decontract the edge
  5) Add E to the minimum spanning tree

NB: Running time is exponential for this -- NO GOOD.

Algorithm (Very similar to Dijkstra's):

  1) Initialize a priority Queue with all vertexes
    having a weight of INFINITY
  2) Choose Arbirtary Starting vertex and initialize
    this weight to 0

  3) Until Queue is Empty
      a) Extract Minimum Vertex
      b) For Each Outgoing Edge
        1) Relax Each vertex i.e.
          Update vertex's weight in the priority queue
          to the weight of the outgoing edge. if
          incoming edge is less than current weight.
          Update vertex's predecessor relationship

  4) Return each parent until the parent is nil.





=end
