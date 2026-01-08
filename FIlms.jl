using LinearAlgebra
films_in_order = ["Squid game 1st series", "Jurassic Park 1", "Oppenheimer", "Breaking Bad 1st series", "Kung Fu Panda 1", "Hunger Games 1", "Inside Out 1", "Shrek 1"]
names_in_order = ["Demir", "Sumana", "Gia Hy Mai", "Zhiyong He", "Filip"]
rating_matrix = [7.0	8	9	8	10	8	8	9;
                9	8	9	6	7	6	6	6;
                7	8	10	9	7	9	5	6;
                8	8	10	9	7	7	6	8;
                9	7	8	8	9	9	9	7]
display(rating_matrix)
# Missing Chris' entries
chris_half = [8.0, 8,0,0,7,0,9,0]
filled_entries = [1, 1, 0, 0, 1, 0, 1, 0]
# 0 are for the missing values
# predicting

# Shift by the average to get biggest and most informative vectors
# '.' is elementwise operation in Jullia 
average_of_matrix = round(sum(rating_matrix) / length(rating_matrix); digits=2)
rating_matrix .-= average_of_matrix
chris_half .-= average_of_matrix
chris_half .*= filled_entries

# Test
for i in 1:4
    for j in (i+1):5
        d = dot(rating_matrix[i, :], rating_matrix[j, :])
        n = norm(rating_matrix[i, :]) * norm(rating_matrix[j, :])
        ang = acos(d/n) * (180/pi)
        println(names_in_order[i] , " vs " , names_in_order[j] , ": " , ang)
    end
end

# Calculate anlge Criss vs Everyone else, pick the smallest anlge

for i in 1:5
    d = dot(rating_matrix[i, :], chris_half)
    n = norm(rating_matrix[i, :]) * norm(chris_half)
    ang = acos(d/n) * (180/pi)
    println(names_in_order[i] , " vs Chris: " , ang)
end

# Filip and Cris have the smallest angle between them
# We will 