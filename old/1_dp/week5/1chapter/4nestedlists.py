# List can nest inside lists

board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
board[1][1] = "X"
board[0][2] = "O"

print("  1 2 3")
for row in range(3):
    print(row + 1, end=" ")
    for col in range(3):
        print(board[row][col], end=" ")
    print()