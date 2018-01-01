require_relative 'graph'
require 'byebug'
=begin

Algorithm for Directed Acyclic Graphs(DAGS)

1. Topologically Sort them
2. For any arbitrary starting vertex, mark all verteces to the
  left as INFINITY as they cannot be reached.
3. Relax each edge going to each vertex.

NB: Cannot use cycles, but CAN use negative edges.

=end


# O(|V|**2 + |E|).

def dijkstra1(vertex)
  shortest_paths = {}
  possible_paths = { vertex => {cost: 0, edge: nil } }
  until possible_paths.length == 0
    next_vertex = find_min_vertex(possible_paths)
    shortest_paths[next_vertex] = possible_paths[next_vertex]
    possible_paths.delete(next_vertex)

    next_vertex.out_edges.each do |edge|
      possible_cost = shortest_paths[edge.from_vertex][:cost] +
        edge.cost
      last_cost = possible_paths[edge.to_vertex]
      if !last_cost || possible_cost < last_cost[:cost]
        possible_paths[edge.to_vertex] = {cost: possible_cost,
          edge: edge}
      end
    end
  end

  shortest_paths
end


def find_min_vertex(hash)
  min_value = hash.values.sort_by { |hash| hash[:cost] }.first
  next_vertex = hash.find { |k, v| v == min_value }[0]
end

=begin
Proof:

Consider there was a better way
to get to some vertex, x, then that
provided by the algorithm.

Clearly, this path must use one of the outgoing edges from the start
to get there.

Going against dijkstra's algorithm, we would
then choose a vertex with a non-minimum expected distance.

In order to get to vertex x, we would clearly
incur the cost of that non-minimum distance. 






Th

=end
