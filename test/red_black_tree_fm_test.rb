require 'test_helper'
require 'finite_machine'
require_relative '../lib/red_black_tree'

class RedBlackTreeFmTest < Minitest::Test
  def test_rb_tree
    tree   = RedBlackTree.new
    list   = []
    transitions = []

    fm = FiniteMachine.define do
      initial :empty

      events {
        event :next, from: [:empty, :add, :remove] do
           choice :add, if: -> (context, w) { w < 0.5 || list.empty? }
           choice :remove, if: -> (context, w) { w >= 0.5 || !list.empty? }
        end
      }

      callbacks {
        on_transition(:add) do |evt|
          key = rand(1024), val = rand(1024)

          list.push(val) unless list.include?(val)
          tree[key] = val
        end

        on_transition(:remove) do |evt|
          key = tree.keys.shuffle.first

          list.delete(tree[key])
          tree.delete(key)
        end

        on_transition do |evt|
          transitions.push(evt.from)
        end
      }
    end

    1.upto(100).each do |n|
      fm.restore!(:empty)

      list = []
      tree = RedBlackTree.new
      transitions = []

      n.times do
        fm.next(rand)
        assert_equal list.length, tree.length, [transitions, tree, list].map(&:inspect)
      end
    end
  end
end
