def has_cycle?(vertices)
  not_visited = Set.new(vertices)
  visited = Set.new
  path = {}

  #Until there are no more elements that are not visited.
  until not_visited.empty?

    #Visit an arbitrary vertex in the not visited path.
    has_cycle = visit(not_visited.to_a[0], visited,
      not_visited, Set.new, path)

    #If there is a cycle, retrace the steps
    return retrace(has_cycle, path) if has_cycle
  end

  #Implicitly return false.
  return false
end

def visit(vertex, visited, not_visited, visiting, path)
  return vertex.value if visiting.include?(vertex)
  #If we are visiting it then return the vertex
  return false if visited.include?(vertex)
  #If we have already visited it then return false

  #Delete from not visited and add to visiting.
  not_visited.delete(vertex)
  visiting.add(vertex)

  #For each vertex explore them
  vertex.out_edges.each do |edge|

    #Set our current vertex to our
      #vertex's child so that we can retrace
    path[vertex.value] = edge.to_vertex.value
    has_cycle = visit(edge.to_vertex, visited,
      not_visited, visiting, path)
      #If there is a cycle don't explore any longer
        #and break out of it
    return has_cycle if has_cycle
  end

  #delete from the visiting, add to the visited.
  visiting.delete(vertex)
  visited.add(vertex)

  return false
end

def retrace(vertex, path)
  #Recursive Case: If there is only one value in the path,
  return path.keys + path.values if path.length == 1
  #Otherwise store the next_vertex
  next_vertex = path[vertex]
  #Delete the current vertex from the path
  path.delete(vertex)
  #[current vertex] + trace back the next vertex
  return [vertex] + retrace(next_vertex, path)
end
