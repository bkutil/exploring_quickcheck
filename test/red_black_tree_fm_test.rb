require 'test_helper'
require 'finite_machine'
require 'test_helper'
require_relative '../lib/red_black_tree'

class RedBlackTreeFmTest < Minitest::Test
  def test_rb_tree
    m = TestMachine.new
    1.upto(100) do |n|
      m.restore!
      n.times do
        m.next(rand)
      end

      assert_equal m.tree.length, m.list.length, [m.history, m.tree.to_a, m.list].map(&:inspect)
      assert_equal m.tree.keys.sort, m.list.sort, [m.history, m.tree.to_a, m.list].map(&:inspect)
    end
  end
end

# A finitime machine that records its state transitions
class TestMachine
  attr_accessor :state_machine

  attr_accessor :history
  attr_accessor :tree
  attr_accessor :list

  def method_missing(name, *args, &block)
    if state_machine.respond_to?(name)
      state_machine.send(name, *args, &block)
    else
      super
    end
  end

  def restore!
    @tree = RedBlackTree.new
    @list = []
    @history = []
    @state_machine = build_state_machine
  end

  def build_state_machine
    context = self

    FiniteMachine.define do
      initial :empty

      target context

      events {
        event :next, from: [:empty, :add, :remove] do
           choice :add,    if: -> (context, w) { w < 0.5 }
           choice :remove, if: -> (context, w) { w >= 0.5 }
        end
      }

      callbacks {
        on_transition(:add) do |evt|
          key = rand(1024), val = rand(1024)

          context.list.push(key) unless context.list.include?(key)
          context.tree[key] = val
        end

        on_transition(:remove) do |evt|
          key = context.tree.keys.shuffle.first

          context.list.delete(key)
          context.tree.delete(key)
        end

        on_transition do |evt|
          context.history.push(evt.from)
        end
      }
    end
  end
end

