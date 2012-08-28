
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

  def add_child node
    @max_child_value = node.evaluate if node.evaluate > @max_child_value
    @min_child_value = node.evaluate if node.evaluate < @min_child_value
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
    nodea = MinimaxNode.new
    nodea.set_value 15
    node.add_child nodea
    nodeb = MinimaxNode.new
    nodeb.set_value 5
    node.add_child nodeb

    node.evaluate_max.should eq 15
  end

  it "should evaluate a min node as the minimum value of its children" do
    node = MinimaxNode.new
    nodea = MinimaxNode.new
    nodea.set_value 15
    node.add_child nodea
    nodeb = MinimaxNode.new
    nodeb.set_value 5
    node.add_child nodeb

    node.evaluate_min.should eq 5
  end

  #it "should correctly evaluate a complex minimax tree" do
    ## MIN               -6
    ## MAX         4            -6
    ## MIN     -4     4     -8      -6
    ## MAX    5 -4   7 4   -8 10   -4 -6
    #nodea = MinimaxNode.new
    #nodea.set_value 5
    #nodeb = MinimaxNode.new
    #nodeb.set_value -4
    #nodeab = MinimaxNode.new
    #nodeab.add_child nodea
    #nodeab.add_child nodeb
    #nodec = MinimaxNode.new
    #nodec.set_value 7
    #noded = MinimaxNode.new
    #noded.set_value 4
    #nodecd = MinimaxNode.new
    #nodecd.add_child nodec
    #nodecd.add_child noded
    #nodeabcd = MinimaxNode.new
    #nodeabcd.add_child nodeab
    #nodeabcd.add_child nodecd
    #nodee = MinimaxNode.new
    #nodee.set_value -8
    #nodef = MinimaxNode.new
    #nodef.set_value 10
    #nodeef = MinimaxNode.new
    #nodeef.add_child nodee
    #nodeef.add_child nodef
    #nodeg = MinimaxNode.new
    #nodeg.set_value -4
    #nodeh = MinimaxNode.new
    #nodeh.set_value -6
    #nodegh = MinimaxNode.new
    #nodegh.add_child nodeg
    #nodegh.add_child nodeh
    #nodeefgh = MinimaxNode.new
    #nodeefgh.add_child nodeef
    #nodeefgh.add_child nodegh
    #nodeabcdefgh = MinimaxNode.new
    #nodeabcdefgh.add_child nodeabcd
    #nodeabcdefgh.add_child nodeefgh

    #nodeabcdefgh.evaluate_min.should eq -6
  #end
end
