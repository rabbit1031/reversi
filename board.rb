# coding: utf-8

class Board

    attr_reader :turn, :board, :num_stone

    # マスの状態
    NONE = 0
    WALL = 1
    BLACK = 2
    WHITE = 3

    def initialize()
        clear()
    end

    # 盤面を初期化する
    def clear()
        @board = Array.new(10).map do
            Array.new(10, NONE)
        end

        # 初期配置
        put_stone!([4, 5], BLACK)
        put_stone!([5, 4], BLACK)
        put_stone!([4, 4], WHITE)
        put_stone!([5, 5], WHITE)
        for i in 0...10
            put_stone!([0, i], WALL)
            put_stone!([9, i], WALL)
            put_stone!([i, 0], WALL)
            put_stone!([i, 9], WALL)
        end

        @turn = BLACK
        @num_stone = {BLACK => 2, WHITE => 2}
    end

    # 盤面を表示する
    def show()
        # 状態に対応する石
        stone = {
            NONE => "-", WALL => "+", BLACK => "●", WHITE => "◯"
        }
        
        print "turn: #{stone[@turn]}\n"
        print "  a b c d e f g h\n"
        for i in 1..8
                print "#{i} "
            for j in 1..8
                print "#{stone[@board[i][j]]} "
            end
            print "\n"
        end
        puts "BLACK: #{@num_stone[BLACK]}, WHITE: #{@num_stone[WHITE]}"
        print "\n"
    end

    # 石を置く
    def put_stone(pos, color)
        flip_dir = check(pos, color)
        if @board[pos[0]][pos[1]] == NONE && !flip_dir.empty? then
            put_stone!(pos, color)
            @num_stone[color] += 1
            flip(pos, color, flip_dir)

            # 相手に置けるところがあれば手番を交代
            if !check_all((turn == BLACK)? WHITE : BLACK).empty?
                chenge_turn()
            end
            show()
        else
            puts "置けません"
        end
    end

    # 手番の交代
    def chenge_turn()
        @turn = (@turn == BLACK)? WHITE : BLACK
    end

    private
    # 指定された位置に石が置けるかどうか調べる
    def check(pos, color)
        # 相手の石の色
        enemy = (color == BLACK)? WHITE : BLACK

        # 置ける場合はひっくり返す石が並ぶ方向を返す
        flag = Array.new

        # 探索
        [[-1, -1], [-1, 0], [-1, 1], [0, -1],
         [0, 1], [1, -1], [1, 0], [1, 1]
        ].each do |i_dir, j_dir|
            i = pos[0] + i_dir
            j = pos[1] + j_dir
            while @board[i][j] == enemy
                i += i_dir
                j += j_dir
                if @board[i][j] == color then
                    flag.push([i_dir, j_dir])
                end
            end
        end
        flag
    end

    # 空白マスに指定された色の石が置けるかどうか調べる
    def check_all(color)
        # 置ける座標を返す
        pos = Array.new

        for i in 1..8
            for j in 1..8
                if @board[i][j] == NONE && !check([i, j], color).empty? then
                    pos.push([i, j])
                end
            end
        end
        pos
    end

    # 石をひっくり返す
    def flip(pos, color, direction)
        # 相手の石の色
        enemy = (color == BLACK)? WHITE : BLACK

        direction.each do |i_dir, j_dir|
            i = pos[0] + i_dir
            j = pos[1] + j_dir
            while @board[i][j] == enemy
                @board[i][j] = color
                @num_stone[color] += 1
                @num_stone[enemy] -= 1
                i += i_dir
                j += j_dir
            end
        end
    end

    # 石を置く
    # put_stone と違い石が置けるかどうか確認しないので直に使わないこと
    def put_stone!(pos, color)
        @board[pos[0]][pos[1]] = color
    end
end
