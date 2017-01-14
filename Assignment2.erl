-module(assignment2).

%Maria-Bianca Cindroi
%Erlang Assignment2

-export([price/1, stretch_if_square/1, convert/1,
  print_n_0/1, print2_n_0/1,
  print_sum_0_n/1, lg/1, count_one_bits/1,
  print_bits/1, print_bits_rev/1,
  expand_circles/2, print_circles/1, even_fruit/1,
  ferry_vehicles/2, f2c/1, c2f/1, even_odd/1]).



% 2. Refactoring
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Refactored without guards/if cases
price({A, N}) when A == 'apple' -> 11 * N;
price({A, N}) when A == 'orange' -> 15 * N + 2;
price({A, B, N}) when A == 'banana' andalso B == 'costarica' -> 8 * N;
price({A, B, N}) when A == 'banana' andalso B == 'equador' -> 9 * N + 2
.

% Do not modify this function
rect_to_square({rect, A, A}) -> {square, A};
rect_to_square({rect, _, _}) -> not_square
.

%X becomes the rect_to_square of R. in the case in which X is not a square then print R, otherwise make the rect of S and S*2
stretch_if_square(A) ->
  X = rect_to_square(A),
  case X of
    not_square -> A;
    {square, P} -> {rect, P, 2*P}
  end
.


%% Tansform fahrenheit to celsius and vice-versa
f2c(F) -> ((F - 32)*5)/9.
c2f(C) -> (C * (9/5)) + 32
.

%converts from Fahrenheit to celsius and vice-versa
convert(R) ->
  case R of
    {f, F} -> {c, f2c(F)};
    {c, C} -> {f, c2f(C)}
  end
.


% 3. Basic recursion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A.prints the numbers from 0 to a given N
print_0_n(N, N) -> io:format("~p~n", [N]);
print_0_n(N, I) ->
  io:format("~p~n", [I]),
  print_0_n(N, I+1)
.

%3.B. print N to 0
print_n_0(N) -> print_n_0(N,0).
print_n_0(N, N) -> io:format("~p~n", [N-N]);
print_n_0(N, I) ->
  io:format("~p~n", [N-I]),
  print_n_0(N, I+1)
.

%3.C. prints N to 0
print2_n_0(N) -> print2_n_0(N,0).
print2_n_0(N, N) -> io:format("~p~n", [N]);
print2_n_0(N, I) ->
  io:format("~p~n", [N]),
  print2_n_0(N-1, I)
.

%3.D. prints sum 0 to N
print_sum_0_n(N) -> print_sum_0_n(N,  0).
print_sum_0_n(N, N) -> io:format("~p~n", [N] ), N;
print_sum_0_n(N, I) -> io:format("~p~n", [I]), I + print_sum_0_n(N, I+1)
.


% 4. Recursion on bits
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate logarithm of a number
lg(0) -> 0;
lg(N) -> 1 + lg(N div 2)
.

%count bits
count_one_bits(0) -> 0;
count_one_bits(N) ->
  (N rem 2) + count_one_bits(N div 2)
.

%print bits
print_bits(0) -> ok;
print_bits(N) ->
  print_bits(N div 2), io:format("~p~n", [N rem 2])
.

%print bits reversed format
print_bits_rev(0) -> ok;
print_bits_rev(N) ->
  io:format("~p~n", [N rem 2]), print_bits_rev(N div 2)
.

% 5. List comprehensions

%A expand the circle by a specific amount
expand_circles(N, S) -> [{circle, X*N} || {circle, X}  <- S].

%B. print the circle
print_circles(C) -> [io:format("Circle ~p~n", [R]) || {circle, R} <- C], ok.

%C even_fruit takes in a list of pairs(atom and a positive integer) and prints a list of atoms
%use even_odd/1 from assignment1

%even_odd/1 from Assignment1
even_odd(Number) when Number>=0 andalso (Number rem 2 =:=1) -> odd;
even_odd(Number) when Number>=0 andalso (Number rem 2 =:=0) -> even.

%implemented even_fruit
even_fruit(Fruit) -> 
  [Type || {Type, Quantity} <- Fruit, even_odd(Quantity) == even].

%D. ferry_vehicles/2 takes an argument as an int and a list of pairs {Vehicle, Weight} and outputs
%a list of triples {Vehicle1, Vehicle2, M} representing the Vehicles description and their 
%combined weight, where M <=N
ferry_vehicles(N, X) -> [{Vehicle1, Vehicle2, A + B} || {Vehicle1, A} <- X, {Vehicle2, B} <- X, Vehicle1 =/= Vehicle2, (A + B) =< N].



