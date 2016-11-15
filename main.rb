require 'rubygems'
require 'gosu'
require 'pry'
require_relative 'cell'
require_relative 'grid'

class MyWindow < Gosu::Window
  attr_reader :grid
  attr_accessor :cells
  
  GRID_X    = 40
  GRID_Y    = 40
  CELL_SIZE = 25
  
  def initialize
    super width, height, false
    self.caption = 'Game of Life'
    
    @grid = Grid.new(GRID_X, GRID_Y, CELL_SIZE, self)
  end
  
  def draw
    @grid.draw
  end
  
  def update
    if button_down?(Gosu::MsLeft)
      @grid.send_click(clicked_x_cell, clicked_y_cell)
    end
    
    if button_down?(Gosu::MsRight)
      @grid.send_right_click(clicked_x_cell, clicked_y_cell)
    end
    
    if button_down?(Gosu::KbSpace)
      @grid.step
    end
  end
  
  private
  
  def width
    GRID_X * CELL_SIZE
  end
  
  def height
    GRID_Y * CELL_SIZE
  end
  
  def needs_cursor?
    true
  end
  
  def button_down(id)
    case id
    when Gosu::KbRight
      @grid.step
    end
  end
  
  def clicked_x_cell
    (mouse_x / CELL_SIZE).floor
  end
  
  def clicked_y_cell
    (mouse_y / CELL_SIZE).floor
  end
end

window = MyWindow.new
window.show
