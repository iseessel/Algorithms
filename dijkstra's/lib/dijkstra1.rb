require_relative 'graph'
require 'byebug'

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
