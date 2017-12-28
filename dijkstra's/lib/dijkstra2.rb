require_relative 'graph'
require 'byebug'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  priority_map = PriorityMap.new
  best_paths = {}
  priority_map[source] = {cost: 0, edge: nil}
  until priority_map.empty?
    next_vertex, next_val = priority_map.extract
    best_paths[next_vertex] = next_val
    next_vertex.out_edges.each do |edge|
      potential_value = next_val[:cost] + edge.cost
      if !priority_map.has_key?(edge.to_vertex) ||
        potential_value < priority_map[edge.to_vertex][:cost]
      priority_map[edge.to_vertex] = {
        cost: potential_value,
        edge: edge
      }
      end
    end
  end

  best_paths
end
