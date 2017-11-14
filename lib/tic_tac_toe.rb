class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn_count
    @board.select {|slot| slot != " "}.count
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Select a number between 1-9"
    display_board

    input = gets.chomp
    index = input_to_index(input)

    if valid_move?(index)
      move(index, current_player)
    else
      puts "INVALID INPUT"
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.find do |win_arr|
      if @board[win_arr[0]] == "X"
        win_arr.all? {|i| @board[i] == "X"}
      elsif @board[win_arr[0]] =="O"
        win_arr.all? {|i| @board[i] == "O"}
      end
    end
  end

  def full?
    @board.all? {|i| i != " "}
  end

  def draw?
    full? && !won?
  end

  def over?
    !!draw? || !!won?
  end

  def winner
    @board[won?[0]] if !!won?
  end

  def result
    if !!draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end

  def play
    while turn_count < 10
      if !over?
        turn
      else
        return result
      end
    end
  end


end
