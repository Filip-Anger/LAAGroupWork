using LinearAlgebra
# Name 	                    Demir	Sumana  Lahiri 	Gia-Hy-Mai	Zhiyong-He	Filip
# Squid game 1st series
# Jurassic Park 1
# Kung Fu Panda 1
# Inside Out 1
# Oppenheimer
# Breaking Bad 1st series
# Hunger Games 1
# Shrek 1

# A)
ratings_matrix = [  7	9	7	8	10;
                    8	8	8	8	9;
                    10	7	7	7	10;
                    8	6	5	6	10;
                    9	9	10	10	9;
                    8	6	9	9	9;
                    8	6	9	7	10;
                    9	6	6	8	8;  ]


# B
ratings_half = ratings_matrix[1:4, :]
ratings_half_origin = ratings_half - (ones(4) * (transpose(ones(4)) * ratings_half) / 4)
check = transpose(ones(4)) * ratings_half_origin 

half_demir_origin = ratings_half_origin[:, 1]
half_others_origin = ratings_half_origin[:,2:5]

# C
norms = [norm(ratings_matrix[:, i]) for i in 1:5]
mean_norm = sum(norms)/5
differences_percen = (norms .- mean_norm) / mean_norm * 100

# D
angles = zeros(4)
for i in 1:4
    d = dot(half_others_origin[:, i], half_demir_origin)
    n = norm(half_others_origin[:, i]) * norm(half_demir_origin)
    angles[i] = acos(d/n)
end

# Angle of Sumana and other of us - acos(0) = 1
# Normalize, sum = 1
weights = angles ./ sum(angles)


demir_actual_first = ratings_matrix[1:4,1]
demir_predicited_first = Int.(round.(ratings_matrix[1:4, 2:5] * weights, digits = 0))
mean_abs_error_training = norm(demir_actual_first .- demir_predicited_first, 1) / 4

demir_actual_second = ratings_matrix[5:8,1]
demir_predicited_second = Int.(round.(ratings_matrix[5:8, 2:5] * weights))
mean_abs_error_test = norm(demir_actual_second .- demir_predicited_second, 1) / 4



# TSVD
# PLAN: 
ratings_matrix = [  -1.25   9	7	8	10;
                    -0.25	8	8	8	9;
                    1.75	7	7	7	10;
                    -0.25	6	5	6	10;
                    0	    9	10	10	9;
                    0	    6	9	9	9;
                    0       6	9	7	10;
                    0       6	6	8	8;  ]

ones(5, 8)

# normalize ratings around 0 DONE

ratings_matrix[:, 2:5] .-= ones(1, 8) * ratings_matrix[:,2:5] / 8
ratings_matrix
change = 7 - ratings_matrix[1,1]

ratings_matrix *= 5
show(stdout, "text/plain", ratings_matrix)

B = transpose(ratings_matrix) * ratings_matrix
values, Vmatrix = eigen(B, sortby=-)
values = values[1:4]
Vmatrix = Vmatrix[:, 1:4]
singular = sqrt.(values)
sigmaM = Matrix(I, 4, 4) .* singular

Umatrix = zeros(8, 4)
for i in 1:4
    Umatrix[:,i] = 1/singular[i] * ratings_matrix * Vmatrix[:,i]
end
transpose(Vmatrix)
predicted_rank_4 = Umatrix * sigmaM * transpose(Vmatrix)
show(stdout, "text/plain", predicted_rank_4)
println()

dimir_predicted = predicted_rank_4[:, 1] .+ change * ones(8)
display(dimir_predicted)
#u = 1/σ Av

# Make SVD

# Do truncated TSVD with k = 4