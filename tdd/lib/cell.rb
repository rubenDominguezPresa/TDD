class Cell
  attr_accessor :neighbours, :state
  def initialize(state, neighbours)
    @state = state # either 1 or 0 for alive or dead
    @neighbours = neighbours # an array that represents the surrounding cells
  end

  def count_live_neighbours
    neighbounds_num=0
    @neighbours.each{|neigh_status| neigh_status==1 ? neighbounds_num +=1 : neighbounds_num +=0 }
    neighbounds_num
  end
  def regenerate
    # your code here
    neighbounds_num=count_live_neighbours
    (@state==1 && (neighbounds_num==2||neighbounds_num==3)) ? @state=1 : @state=@state
    @state
  end

  def born
    neighbounds_num=count_live_neighbours
    neighbounds_num==3 ? @state=1 : @state=@state
    @state
  end

  def die
    neighbounds_num=count_live_neighbours
    (neighbounds_num==2 || neighbounds_num==3) ? @state=@state : @state=0
    @state
  end
end