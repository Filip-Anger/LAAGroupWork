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
# ratings_matrix = [  9	7	8	10;
#                     8	8	8	9;
#                     7	7	7	10;
#                     6	5	6	10;
#                     9	10	10	9;
#                     6	9	9	9;
#                     6	9	7	10;
#                     6	6	8	8;  ]

# dimir_half = transpose([7.0 8 10 8])

# # normalize ratings around 0 DONE

# ratings_matrix = ratings_matrix .- ones(1, 8) * ratings_matrix / 8
# dimir_half = dimir_half - (transpose(ones(4)) *dimir_half / 4) .* ones(4)


# B = transpose(ratings_matrix) * ratings_matrix
# values, Vmatrix = eigen(B, sortby=-)
# # values = values[1:4]
# # Vmatrix = Vmatrix[:, 1:4]
# singular = sqrt.(values)
# sigmaM = Matrix(I, 4, 4) .* singular

# Umatrix = zeros(8,4)
# for i in 1:4
#     Umatrix[:,i] = 1/singular[i] * (ratings_matrix * (Vmatrix)[:,i])
# end

# # LEASET SQUARRES FROM SVD
# Vmatrix * inv(sigmaM) * transpose(Umatrix)
# dimir_prediction = Vmatrix * inv(sigmaM) * transpose(Umatrix) * dimir_half

# latent_vectors = zeros(4, 4)
# for i in 1:4
#     latent_vectors[:, i] = sigmaM * Umatrix[i, :]
# end
# latent_vectors
# predicted_rank_4 = Umatrix * sigmaM * transpose(Vmatrix)
# show(stdout, "text/plain", predicted_rank_4)
# println()

# dimir_predicted = predicted_rank_4[:, 1] .+ change * ones(8)
# display(dimir_predicted)
# #u = 1/σ Av

# # Make SVD

# # Do truncated TSVD with k = 4



# E)
R = [   7.0	9	7	8	10;
        8	8	8	8	9;
        10	7	7	7	10;
        8	6	5	6	10;
        -1	9	10	10	9;
        -1	6	9	9	9;
        -1	6	9	7	10;
        -1	6	6	8	8;  ]
# Dimir full vector
d = [7 8 10 8 9 8 8 9]
d_actual = d[5:8]
av = sum(R[:, 2:5]) / (4*8)
# R_origin = R .- (transpose(ones(8)) * R) / 8
R[5:8, 1] = ones(4) * av
# WE WANT TO PREDICT USERS!!!
R = transpose(R)
R
# Rows - users
# Column - films
# U 5x5 > Users consist of 5 features
# S 5 sig values
# V 5x8 > films consist of 5 features
# V - take full rows
# U -take full cols
U, S, V = svd(R)

for i in 1:4
    i = 5 - i
    println("RANK ", i)
    S = S[1:i];
    U = U[:, 1:i];
    V = V[:,1:i];
    U * transpose(V)
    R4 = transpose(U * (Matrix(I,i, i) .* S) * transpose(V))
    d_predict = R4[5:8, 1]
    show(round.(d_predict, digits=2))
    mar = round(norm(d_predict .- d_actual,1) / 4, digits=2)
    print("AMR: ", mar)
    println()
    println("---------------")
end

show(stdout, "text/plain", R4)

R4_error = transpose(R) .- R4
d_predict_error_mean = norm(R4[5:8, 1], 1) / 4
mean_per_user = 0
for i in 2:5
    mean_per_user += norm(R4[:, i], 1) / 8
end
mean_per_user/= 5
mean_per_user
# Dimir is user 1
