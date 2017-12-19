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


end
