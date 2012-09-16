
class MinimaxNode
  attr_accessor :value

  def initialize params={}
    @value = params[:value] if params[:value] != nil
    params[:parent].add_child( self ) if params[:parent] != nil
  end

  def add_child node
    if node.value_known? then
      @value = node.value if value_unknown?
      @value = node.value if node.value.send( @comparisonOperator, @value )
    end
  end

  def value_known?
    @value != nil
  end

  def value_unknown?
    @value == nil
  end
end

class MaxNode < MinimaxNode
    def initialize params={}
    @comparisonOperator = :>
  end
end

class MinNode < MinimaxNode
  def initialize params={}
    @comparisonOperator = :<
  end
end

describe "ruby-minimax" do
  it "should evaluate a min node with no children as its own value" do
    node = MinNode.new
    node.value = 10
    node.value.should eq 10
  end

  it "should evaluate a max node with no children as its own value" do
    node = MaxNode.new
    node.value = 10
    node.value.should eq 10
  end

  it "should evaluate a max node as the max value of its children" do
    node = MaxNode.new
    nodea = MinNode.new
    nodea.value = 5
    node.add_child nodea
    nodeb = MinNode.new
    nodeb.value = 15
    node.add_child nodeb

    node.value.should eq 15
  end

  it "should evaluate a min node as the minimum value of its children" do
    node = MinNode.new
    nodea = MaxNode.new
    nodea.value = 15
    node.add_child nodea
    nodeb = MaxNode.new
    nodeb.value = 5
    node.add_child nodeb

    node.value.should eq 5
  end

  #it "should correctly evaluate a three level minimax tree" do
    ## MIN               -6
    ## MAX         4            -6
    ## MIN     -4     4     -8      -6
    #node = MinNode.new
    #nodea = MaxNode.new( :parent=>node )
    #nodeaa = MinNode.new( :parent=>nodea, :value=>-4 )
    #nodeab = MinNode.new( :parent=>nodea, :value=>4 )
    #nodeb = MaxNode.new( :parent=>node )
    #nodeba = MinNode.new( :parent=>nodeb, :value=>-8 )
    #nodebb = MinNode.new( :parent=>nodeb, :value=>-6 )

    #node.value.should eq -6
  #end

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
