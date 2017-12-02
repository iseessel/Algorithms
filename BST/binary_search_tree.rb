require 'byebug'

class BSTNode
  attr_accessor :value, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

end

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    current_node = @root
    if @root.nil?
      return @root = BSTNode.new(value)
    end
    while true
      if value > current_node.value
        if current_node.right.nil?
          new_node = BSTNode.new(value)
          current_node.right = new_node
          return new_node
        end
        current_node = current_node.right
      else
        if current_node.left.nil?
          new_node = BSTNode.new(value)
          current_node.left = new_node
          return new_node
        end
        current_node = current_node.left
      end
    end
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if value == tree_node.value
    if value > tree_node.value
      find(value, tree_node.right)
    else
      find(value, tree_node.left)
    end
  end

  def delete(value)
    current_node = @root
    return @root = nil if @root.value == value
    while true
        if value > current_node.value
          if value == current_node.right.value
            return handle_deletion(current_node.right, current_node, value)
          end
          current_node = current_node.right
      else
        if value == current_node.left.value
          return handle_deletion(current_node.left, current_node, value)
        end
        current_node = current_node.left
      end
    end
  end

  def handle_deletion(node, parent_node, value)
    if node.left && node.right
      nodes = maximum(node.left)
      node_to_replace = nodes[1]
      if node_to_replace.left
        nodes[0].right = node_to_replace.left
      end
      if parent_node.left == node
        parent_node.left = node_to_replace
        node.value = nil
      else
        parent_node.right = node_to_replace
        node.value = nil
      end
    elsif node.left || node.right
      child_node = node.left || node.right
      if parent_node.left == node
        parent_node.left = child_node
        node.value = nil
      else
        parent_node.right = child_node
        node.value = nil
      end
    else
      if parent_node.left == node
        parent_node.left = nil
        node.value = nil
      else
        parent_node.right = nil
        node.value = nil
      end
    end
  end

  # helper method for #delete:
  #NB: I want to return both the parent node and the child node for the delete method.
  def maximum(tree_node = @root)
    return [tree_node, tree_node.right] if tree_node.right.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?
    [depth(tree_node.left), depth(tree_node.right)].max + 1
  end
  #
  # 1) Difference in the depth of the left and right subtrees is at most one.
  # 2) Both left AND right sides of the BST are also balanced.


  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    return false if (depth(tree_node.left) - depth(tree_node.right)).abs > 1
    return is_balanced?(tree_node.left) && is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node.nil?
    in_order_traversal(tree_node.left) +
    [tree_node.value] +
    in_order_traversal(tree_node.right)
  end

  #find the kth largest node in a BST
  def kth_largest(tree_node, k)
    sorted = in_order_traversal(tree_node)
    sorted[-k]
  end

  private

  def children(node)
    children = []
    children.push(node.left) if node.left
    children.push(node.right) if node.right
    node
  end


  # optional helper methods go here:n
end
