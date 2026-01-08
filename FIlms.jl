using LinearAlgebra
films_in_order = ["Squid game 1st series", "Jurassic Park 1",	"Kung Fu Panda 1",	"Inside Out 1",	"Oppenheimer", "Breaking Bad 1st series", "Hunger Games 1",	"Shrek 1"]
names_in_order = ["Demir", "Sumana", "Gia Hy Mai", "Zhiyong He", "Filip"]
rating_matrix = [7	8	10	8	9	8	8	9;
9	8	7	6	9	6	6	6;
7	8	7	5	10	9	9	6;
8	8	7	6	10	9	7	8;
10	9	10	10	9	9	10	8]
rating_of_4_films = rating_matrix[:,1:4]
display(rating_matrix)
# Missing Chris' entries
chris_half = transpose([8.0, 8, 7, 9])
# 0 are for the missing values
# predicting

# Shift by the average to get biggest and most informative vectors
# '.' is elementwise operation in Jullia 

# LAA way: every row - sum/len of that row
# sum of that rows in a vector A * e
# substarct the average from every entry of the matrix
av_per_row = rating_of_4_films * ones(4) / 4
rating_of_4_films -= av_per_row * ones(1, 4)

check = rating_of_4_films * ones(4) / 4
# Average is 0

chris_half * ones(4) / 4
chris_half -= (chris_half * ones(4) / 4) *  ones(1,4)

display(rating_of_4_films)
# Calculate anlge Criss vs Everyone else, pick the smallest anlge

# VERY PRIMITIVE WAY: WIGHTED ANGLES
angles = zeros(5)
for i in 1:5
    d = dot(rating_of_4_films[i, :], chris_half)
    n = norm(rating_of_4_films[i, :]) * norm(chris_half)
    angles[i] = acos(d/n)
end

weights = angles ./ sum(angles)

chris_rest = transpose(weights) * rating_matrix[:,5:8]
# 9.4276  8.2068  7.96232  7.39552
# Criss has these angles with others in V^4
# Find a vector in V^8 which has the same angles with all vectors in V^8

