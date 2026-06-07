# coding: utf-8

require 'tk'
require './board'

# Board と GUIControllerの見た目は転置行列の関係にある
class GUIController
    def initialize(board)
        @window = TkRoot.new(
            "width" => 500,
            "height" => 500
        )
        @board = board
        make_board()
        show()
    end

    # 盤面を作る
    def make_board()
        @canvas = TkCanvas.new(
            @window,
            "width" => 500,
            "height" => 500
        ).pack
        @canvas.bind("1",
            proc{|x,y| put_stone([x, y])}, "%x %y")

        square = Array.new(8).map { Array.new(8) }
        for i in 0...8
            TkLabel.new(@window, "text" => (i+97).chr).place(
                "x" => (i + 2) * 50 - 25,
                "y" => 35,
                "anchor" => "c"
            )
            TkLabel.new(@window, "text" => (i+1).to_s).place(
                "x" => 35,
                "y" => (i + 2) * 50 - 25,
                "anchor" => "c"
            )
            for j in 0...8
                square[i][j] = TkcRectangle.new(
                    @canvas,
                    (i+1) * 50, (j+1) * 50, (i+2) * 50, (j+2) * 50
                )
                square[i][j].fill = "green"
            end
        end

        @score = TkLabel.new(
            @window,
            "text" => "score"
        ).place("x" => 250, "y" => 475, "anchor" => "c")
    end

    def put_stone(pos)
        i = pos[0] / 50
        j = pos[1] / 50
        if i >= 1 && i <= 8 && j >= 1 && j <= 8 then
            pos = [i, j]
            @board.put_stone([i, j], @board.turn)
            show()
        end
    end

    # 盤面を表示する
    def show()
        for i in 1..8
            for j in 1..8
                if @board.board[i][j] == Board::BLACK || @board.board[i][j] == Board::WHITE then
                    show_stone([i, j], @board.board[i][j])
                end
            end
        end

        # スコア表示
        if @board.turn == Board::BLACK then
            @score.text = "*BLACK: #{@board.num_stone[Board::BLACK]} - #{@board.num_stone[Board::WHITE]} :WHITE"
        else
            @score.text = "BLACK: #{@board.num_stone[Board::BLACK]} - #{@board.num_stone[Board::WHITE]} :WHITE*"
        end
    end

    # 石を指定したマスに表示する
    def show_stone(pos, color)
        TkcOval.new(
            @canvas,
            pos[0] * 50, pos[1] * 50, (pos[0] + 1) * 50, (pos[1] + 1) * 50
        ) do |stone|
            stone.fill = (color == Board::BLACK)? "black" : "white"
        end
    end
end
