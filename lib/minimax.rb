
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
