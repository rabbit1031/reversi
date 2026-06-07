# coding: utf-8

require 'tk'
require './board'

class BoardGUI < Board
    def initialize()
        super()
        @window = TkRoot.new(
            # "title" => "Othello",
            "width" => 500,
            "height" => 500
        )
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
        @canvas.bind("1", proc{|x,y| put_stone([x, y], @turn)}, "%x %y")

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
                    (i + 1) * 50, (j + 1) * 50, (i + 2) * 50, (j + 2) * 50
                )
                square[i][j].fill = "green"
            end
        end

        @score = TkLabel.new(
            @window,
            "text" => "score"
        ).place("x" => 250, "y" => 475, "anchor" => "c")
    end

    # 盤面を表示する
    def show()
        for i in 1..8
            for j in 1..8
                if @board[i][j] == BLACK || @board[i][j] == WHITE then
                    show_stone([i, j], @board[i][j])
                end
            end
        end

        # スコア表示
        if @turn == BLACK then
            @score.text = "*BLACK: #{@num_stone[BLACK]} - #{@num_stone[WHITE]} :WHITE"
        else
            @score.text = "BLACK: #{@num_stone[BLACK]} - #{@num_stone[WHITE]} :WHITE*"
        end
    end

    # 石を指定したマスに表示する
    def show_stone(pos, color)
        TkcOval.new(
            @canvas,
            pos[0] * 50, pos[1] * 50, (pos[0] + 1) * 50, (pos[1] + 1) * 50
        ) do |stone|
            stone.fill = (color == BLACK)? "black" : "white"
        end
    end

    # クリックされた位置を受け取って石を置く
    def put_stone(pos, turn)
        # 座標からマスの位置を計算
        i = pos[0] / 50
        j = pos[1] / 50
        puts "#{i}, #{j}\n"

        if i >= 1 && i <= 8 && j >= 1 && j <= 8 then
            pos = [i, j]
            if @board[i][j] == NONE then
                flip_dir = check(pos, turn)
                if !flip_dir.empty? then
                    put_stone!(pos, turn)
                    @num_stone[turn] += 1
                    flip(pos, turn, flip_dir)

                    # 相手に置けるところがあれば手番を交代
                    if !check_all((turn == BLACK)? WHITE : BLACK).empty?
                        chenge_turn()
                    end
                    show()
                end
            end
        end
    end
end

BoardGUI.new()
Tk.mainloop
