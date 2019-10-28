# Checks whether a row is solved
def row_solved?(row)
  row.reduce(0, :+) == 34
end

# Checks whether all rows are solved
def rows_solved?(matrix)
  matrix.each do |row|
    return false unless row_solved?(row)
  end

  true
end

# Checks whether all columns are solved
def columns_solved?(matrix)
  rows_solved?(matrix.transpose)
end

# Checks whether both diagonals are solved
def diagonals_solved?(matrix)
  diagonal_1 = (0..3).collect { |i| matrix[i][i] }
  diagonal_2 = (0..3).collect { |i| matrix[i][3 - i] }

  row_solved?(diagonal_1) && row_solved?(diagonal_2)
end

# Checks whether the matrix contains any empty slots
# Flattens the matrix, selects zeros and return of there are any
def has_null?(matrix)
  matrix.flatten.select(&:zero?).any?
end

# Check whether the matrix is solved
def is_solved?(matrix)
  !has_null?(matrix) &&
    rows_solved?(matrix) &&
    columns_solved?(matrix) &&
    diagonals_solved?(matrix)
end

# Finds empty slot. Checks for zeros
# Returns the i, j of the first empty slot
def find_empty_slot(matrix)
  matrix.each_with_index do |row, i|
    row.each_with_index do |ele, j|
      return { i: i, j: j } if ele.zero?
    end
  end
end

# Prints array in a 2D format.
def print_arr(matrix)
  system('clear')
  matrix.each do |row|
    p row.join(', ')
  end
end

# Finds remaining elements in a matrix
# Selects all non zero entities, and subtracts them from
# a range of 1 to N*N
def remaining(matrix)
  [*1..16] - matrix.flatten.reject(&:zero?)
end

# Recursive method to find the solution for a given matrix.
# Returns true, if the matrix is solved, false if no solution found

def solve(matrix)
  # Base case
  return true if is_solved? matrix

  # Iterating over remaining numbers
  remaining(matrix).each do |remaining_number|
    # Finding a slot to fit in a number
    slot = find_empty_slot matrix

    # Filling the number in the found slot
    matrix[slot[:i]][slot[:j]] = remaining_number

    # Recursive call to the method
    # to check if its solved or not
    return true if solve matrix

    # We reach here when we didn't find a solution
    # in the above iteration, so we reset the slot
    # to zero, and go ahead with our loop
    matrix[slot[:i]][slot[:j]] = 0
  end

  false
end

# Main method to initialize the problem matrix,
# and to make the seed recursive call
# Prints the solved matrix if solution is found.
# Else prints 'No answer'
def main
  matrix = [
    [1, 0, 0, 4],
    [10, 0, 8, 5],
    [0, 0, 9, 0],
    [16, 0, 0, 13]
  ]

  if solve matrix
    print_arr matrix
  else
    puts 'No answer'
  end
end

main
