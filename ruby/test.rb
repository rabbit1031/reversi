# coding: utf-8

require 'tk'
require './board'
require './guicontroller'

board = Board.new()
board.show()
guictrl = GUIController.new(board)

Tk.mainloop
