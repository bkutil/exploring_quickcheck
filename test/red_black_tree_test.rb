require 'test_helper'
require_relative '../lib/red_black_tree'

class RedBlackTreeTest < Minitest::Test
  def test_rb_tree
    tree_gen = lambda do |n|
      t = RedBlackTree.new
      while t.length < n
        t[rand] = rand
      end
      t
    end

    prop_red_red = lambda do |node|
      if node.red?
        assert(!node.left.red?) if node.left
        assert(!node.right.red?) if node.right
      end
      prop_red_red.call(node.left) if node.left
      prop_red_red.call(node.right) if node.right
    end

    property_of {
      n = range(0, 400)
      tree = tree_gen.call(n)
      [n, tree]
    }.check do |n, tree|
      assert_equal tree.length, n

      prop_red_red.call(tree.root)
    end

    property_of {
      n = range(0, 400)
      tree = tree_gen.call(n)
      [n, tree]
    }.check do |n, tree|
      x = tree.keys.shuffle.first
      tree.delete(x)
      assert !tree.keys.include?(x)
    end
  end

  def test_check_height_on_empty_tree
    tree = RedBlackTree.new
    assert_silent { tree.root.check_height }
  end
end
