class Cell
  attr_accessor :x, :y, :alive, :next
  
  def initialize(x, y)
    @x = x
    @y = y
    @alive = false
  end
  
  def toggle
    @alive = !@alive
  end
  
  def alive?
    @alive
  end
  
  def step(living_neighbors_count)
    if @alive
      case living_neighbors_count
      when 0..1
        @next = false
      when 2..3
        @next = true
      when 4..8
        @next = false
      end
    else
      @next = living_neighbors_count == 3 ? true : false 
    end
  end
  
  def set_next
    @alive = @next
  end
  
  def alive!
    @alive = true
  end
  
  def kill!
    @alive = false
  end
end
