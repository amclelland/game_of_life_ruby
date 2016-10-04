class Grid
  attr_reader :window, :grid_x, :grid_y, :cell_size, :dead_color, :alive_color
  attr_accessor :cells
  
  def initialize(x, y, cell_size, window)
    @window = window
    @grid_x = x
    @grid_y = y
    @cell_size = cell_size
    
    @dead_color = Gosu::Color.argb(0xff_808080)
    @alive_color = Gosu::Color.argb(0xff_ffff00)
    
    @cells = []
    (0..@grid_x).each do |x|
      row = []
      
      (0..@grid_y).each do |y|
        row << Cell.new(x, y)
      end
      
      @cells << row
    end
  end
  
  def draw
    @cells.flatten.each do |cell|
      draw_cell(cell)
    end
    
    draw_grid_lines
  end
  
  def send_click(x, y)
    cell = @cells[x][y]
    cell.alive!
  end
  
  def send_right_click(x, y)
    cell = @cells[x][y]
    cell.kill!
  end
  
  def step
    @cells.flatten.each do |cell|
      cell.step(living_neighbors_count(cell))
    end
    
    @cells.flatten.each do |cell|
      cell.set_next
    end
  end
  
  private
  
  def living_neighbors_count(cell)
    neighbors = []
    
    ((cell.x-1)..(cell.x+1)).each do |x|
      ((cell.y-1)..(cell.y+1)).each do |y|
        next if x == cell.x && y == cell.y
        neighborx = @cells[x]
        neighbor = neighborx ? neighborx[y] : nil 
        neighbors << neighbor unless neighbor.nil?
      end
    end
    
    neighbors.map { |neighbor| neighbor.alive? }.count(true)
  end
  
  def draw_cell(cell)
    color = cell.alive? ? @alive_color : @dead_color
    x = cell.x * @cell_size
    y = cell.y * @cell_size
    
    draw_rect(cell.x * @cell_size, cell.y * @cell_size, color)
  end
  
  def draw_rect(x, y, color)
    window.draw_quad(x, y, color, x + @cell_size, y, color, x, y + @cell_size, color, x + @cell_size, y + @cell_size, color)
  end
  
  def draw_grid_lines
    color = Gosu::Color.argb(0xff_000000)
    
    (0..@grid_x).each do |x|
      window.draw_line(x * @cell_size, 0, color, x * @cell_size, (@grid_y+1) * @cell_size, color)
    end
    
    (0..@grid_y).each do |y|
      window.draw_line(0, y * @cell_size, color, (@grid_x+1) * @cell_size, y * @cell_size, color)
    end
  end
end
