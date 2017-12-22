require_relative 'graph'

=begin

# Implementing topological sort using both Khan's and Tarian's algorithms

# Given a Directed Acyclic Graph (DAG) is a linear ordering of vertices
such that for every directed edge(u, v), vertex u comes before v in the ordering.

NB: Topological sort is not unqiue

Applications:

1) Build Systems -> Building projects. If project has various libraries
  then IBE can use a topological sort!
2) Advanced-Packaging Tool -> Install/remove softwares list of packages.
3) Task Scheduling -> Scheduling interdepndent task to which task preceeds
  which one
4) Pre-Requisite problems -> There exists a prerequisite, thus we can do
  a topological sort!

=end

  def topological_sort(vertices)
    result = []
    visited = {}
    #Set visited hash to all false
    vertices.each { |vertex| visited[vertex] = false }

    # Until all nodes are visited
    until visited.all? { |vertex, visited| visited }

      #find the unvisited items.
      non_visited_vertices = visited.reject { |vertex, visited| visited }.keys

      #visit any unvisited vertex (arbitrarily the first)
      has_no_cycle = visit(non_visited_vertices[0],
        result, visited)

      # If there is a cycle then return an empty array.
      return [] if !has_no_cycle
    end

    #Return the result.
    result
  end

  def visit(vertex, result, visited, visiting = {})
    #First check if we are in the proccess of visiting the vertex,
      #If we are there is a cycle.
    return false if visiting[vertex]

    #Then check if we have put it into the already visited box. If we have
      #Return out of it.
    return true if visited[vertex]

    #On the way down mark the currently looked at vertex as visited
    visiting[vertex] = true

    #For each connected vertex
    vertex.out_edges.each do |edge|
      #Visit that vertex
      has_no_cycle = visit(edge.to_vertex, result,
        visited, visiting)

      #If that vertex has a cycle return out of it.
      return false if !has_no_cycle
    end

    #On the way back up after we have visited all the chilrden
      #Mark it as non visiting.
    visited[vertex] = true
    visiting[vertex] = false
    result.unshift(vertex)
  end


# Kahn's Algorithm: O(|E| + |V|)

  def k_topological_sort(vertices)
    topological_order = []

    degrees = {}
    #count the number of in edges for each vertex O(|V|)
    vertices.each { |vertex| degrees[vertex] = vertex.in_edges.length }

    #Select those with no in edges
    queue = degrees.select { |vertex, length| length == 0 }.keys

    until queue.empty?
      topological_order.push(queue.pop)

      #for each out edge, decrement the to vertexes incoming
        #edge count by one
      vertex.out_edges.each do |edge|
        degrees[edge.to_vertex] -= 1

        #If there are no more in edges, add it to the queue!
        if degrees[edge.to_vertex] == 0
          queue.unshift(edge.to_vertex)
        end
      end
    end
    #When there is a cycle, the queue will be empty before each node will
      #have been checked; therefore the results array will equal
      #the vertex array iff there is a topological ordering.
     if topological_order.length == vertices.length
       topological_order
     else
       []
     end
   end
