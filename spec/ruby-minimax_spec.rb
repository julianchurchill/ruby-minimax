
class MinimaxNode
  attr_accessor :value

  def initialize params={}
    @children = []
    @value = params[:value] if params[:value] != nil
    params[:parent].add_child( self ) if params[:parent] != nil
  end

  def value
    @value = find_best_child.value if value_unknown?
    return @value
  end

  def find_best_child
    best = nil
    @children.each { |child| best = child if best_child? child }
    return best
  end

  def best_child? child
    return true if value_unknown?
    return child.value.send( @comparisonOperator, @value )
  end

  def value_known?
    @value != nil
  end

  def value_unknown?
    @value == nil
  end

  def add_child child
    @children += [child]
  end
end

class MaxNode < MinimaxNode
    def initialize params={}
    @comparisonOperator = :>
    super( params )
  end
end

class MinNode < MinimaxNode
  def initialize params={}
    @comparisonOperator = :<
    super( params )
  end
end

describe "ruby-minimax" do
  it "should evaluate a min node with no children as its own value" do
    node = MinNode.new( :value=>10 )

    node.value.should eq 10
  end

  it "should evaluate a max node with no children as its own value" do
    node = MaxNode.new( :value=>10 )

    node.value.should eq 10
  end

  it "should evaluate a max node as the max value of its children" do
    node = MaxNode.new
    nodea = MinNode.new( :parent=>node, :value=>5 )
    nodeb = MinNode.new( :parent=>node, :value=>15 )

    node.value.should eq 15
  end

  it "should evaluate a min node as the minimum value of its children" do
    node = MinNode.new
    nodea = MaxNode.new( :parent=>node, :value=>15 )
    nodeb = MaxNode.new( :parent=>node, :value=>5 )

    node.value.should eq 5
  end

  it "should correctly evaluate a three level minimax tree" do
    # MIN               -6
    # MAX         4            -6
    # MIN     -4     4     -8      -6
    node = MinNode.new
    nodea = MaxNode.new( :parent=>node )
    nodeaa = MinNode.new( :parent=>nodea, :value=>-4 )
    nodeab = MinNode.new( :parent=>nodea, :value=>4 )
    nodeb = MaxNode.new( :parent=>node )
    nodeba = MinNode.new( :parent=>nodeb, :value=>-8 )
    nodebb = MinNode.new( :parent=>nodeb, :value=>-6 )

    node.value.should eq -6
  end

  it "should correctly evaluate a four level minimax tree" do
    #MIN               -6
    #MAX         4            -6
    #MIN     -4     4     -8      -6
    #MAX    5 -4   7 4   -8 10   -4 -6
    node = MinNode.new
    nodea = MaxNode.new( :parent=>node )
    nodeaa = MinNode.new( :parent=>nodea )
    nodeaaa = MaxNode.new( :parent=>nodeaa, :value=>5 )
    nodeaab = MaxNode.new( :parent=>nodeaa, :value=>-4 )
    nodeab = MinNode.new( :parent=>nodea )
    nodeaba = MaxNode.new( :parent=>nodeab, :value=>7 )
    nodeabb = MaxNode.new( :parent=>nodeab, :value=>4 )
    nodeb = MaxNode.new( :parent=>node )
    nodeba = MinNode.new( :parent=>nodeb )
    nodebaa = MaxNode.new( :parent=>nodeba, :value=>-8 )
    nodebab = MaxNode.new( :parent=>nodeba, :value=>10 )
    nodebb = MinNode.new( :parent=>nodeb )
    nodebba = MaxNode.new( :parent=>nodebb, :value=>-4 )
    nodebbb = MaxNode.new( :parent=>nodebb, :value=>-6 )

    node.value.should eq -6
  end
end
