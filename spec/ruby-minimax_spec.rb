
class MinimaxNode
  def initialize
    @max_child_value = -100000000
    @min_child_value = 100000000
  end

  def set_value value
    @value = value
  end

  def evaluate
    @value
  end

  def evaluate_max
    @max_child_value
  end

  def evaluate_min
    @min_child_value
  end

  def add_child value
    @max_child_value = value if value > @max_child_value
    @min_child_value = value if value < @min_child_value
  end
end

describe "ruby-minimax" do
  it "should evaluate a leaf node as its own value" do
    node = MinimaxNode.new
    node.set_value 10
    node.evaluate.should eq 10
  end

  it "should evaluate a max node as the max value of its children" do
    node = MinimaxNode.new
    node.add_child 15
    node.add_child 5
    node.evaluate_max.should eq 15
  end

  it "should evaluate a min node as the minimum value of its children" do
    node = MinimaxNode.new
    node.add_child 15
    node.add_child 5
    node.evaluate_min.should eq 5
  end
end
