class DisjointSet

  def initialize(number)
    @size = (0..number).map { |el| 1 }
    @forest = (0..number).map { |el| el }
  end

  def connected?(i, j)
    # do they have the same roots?
    root(i) == root(j)
  end

  def union(i, j)
    i_root = root(i)
    j_root = root(j)
    raise 'already connected' if i_root == j_root
  #if tree of root i is greater than tree of root j
    if @size[i_root] >= @size[j_root]
       @forest[j_root] = i_root
      #update size of tree i
      @size[i_root] += @size[j_root]
    else
      #set tree j to be parent of tree i
      @forest[i_root] = j_root
      #update size of tree j
      @size[j_root] += @size[i_root]
    end
  end

  def root(i)
    if @forest[i] != i
      #Path Compression
      @forest[i] = root(@forest[i])
    else
      return i
    end
  end

end

=begin

Practical Applications

Percolation

1) N by N Grid
2) Each site is open(white) with probability p
  or blocked with proability (1 - p) (black)
3) System percolates iff

top and bottom are connected by open sites.


Phase transition
  1) threshold between when it percolates and doesn't percolate
    is SHARP
  2) Solution for this is COMPUTATIONAL METHODS THAT USE FAST UNION FIND

Monte-Carlo Simulation
  1) Iniitialize N-by-N to be blocked
  2) Declare random sites open until top connected to bottom
  3) Vacancy percentage estimates p*

Run this experiment millions of time.

1) Create an object for each site
 and name them 0 to n^2 - 1
2) Sites are in same component if connected by open sites
3) Introduce two virtual sites and connections to top and bottom
4) Merely check if the virtual bottom site
  connects to virtual top site!

Open Site
  1) Union it and all surrounding blocks


1 2 3 4 5 6 7 8 9

[1, 1]

1 2
3 4
5 1

def all_connected?
  check if any of the sizes
   is equal to the length of the array
end


=end
