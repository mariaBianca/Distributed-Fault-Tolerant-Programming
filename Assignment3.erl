-module(assignment3).

-export([sum/1, sum_interval/2, interval/2,
	 sum_interval2/2, adj_duplicates/1,
	 even_print/1, even_odd/1, even_print2/1,
	 normalize/1, normalize2/1, max_norm/1,
         sum2/1, last/1, mul/1, find/2, sort/1,
         dict_new/0, dict_get/2, dict_put/3,
         dict_wellformed/1, dict_map_values/2,
         tree_leaf/0, tree_branch/3, tree_deconstruct/1,
         tree_wellformed/1, tree_make_bfs/1, tree_bind/2,
         tree_flatten/1, tree_dfs/1, tree_sorted/1, tree_find/2,
         digitize/1, is_happy/1, all_happy/2,
         expr_eval/1, expr_print/1
        ]).

% Maria-Bianca Cindroi
%DIT027 Distributed Fault-Tolerant Programming 

% 1. Basic functions, lists and tuples
% A. Do not modify this function 
sum([])     -> 0;
sum([X|Xs]) -> X + sum(Xs).

%B. [1]
% give interval (N, M), calculate the sum of the values inside
%otherwise return 0
sum_interval(N,M) when (N > M) -> 0;
sum_interval(N,M) -> N + sum_interval(N+1, M). 

%C. [2]
%return the list within the given interval
%if the interval is upside down ([N,M], N>M), return empty list
interval(N, M) when N > M -> [];
interval(N,M) -> [N | interval(N+1,M)].

%D. [3]
%reimplement sum_interval2/2 with the help of C and A
sum_interval2(N, M) when N > M -> 0;
sum_interval2(N,M) -> sum(interval(N,M)).

%E. [4]
%given a list, find out if any 2 consecutive elemens repeat, and return the doubled element
%otherwise return an empty list
adj_duplicates([]) -> [];
adj_duplicates([L,L|Ls]) -> [ L | adj_duplicates([L|Ls]) ];
adj_duplicates([_|Ls])  -> adj_duplicates(Ls).

%F. [5]
%print all the list of even numbers in a given list on a separate line. The function should return ok, if empty list.
even_print([]) -> ok;
even_print(L) when hd(L) rem 2 =:= 0 -> io:format("~p~n", [hd(L)]), even_print(tl(L)), ok;
even_print(L) -> even_print(tl(L)).

%G. [6]
%given a variable, print if it is even or odd.
even_odd(X) when X rem 2 == 0 -> even;
even_odd(_)     -> odd.

%H. [7] reimplement F. with function G.
%even_print2([]) -> ok;
even_print2(L) -> [io:format("~p~n", [X]) || X <- L, even_odd(X) == even], ok.


%I. [8] given a list of numbers, normalize the list by dividing all its elements with the biggest of them all.
%an auxiliar function is build in order to be able to find out the maximum of them.
%the auxiliar function is used in the implementation of the above normalization function, in order to determine
%the maximum element of the list, so the rest of the elements could be divided by it.
max_norm([H]) -> H;
max_norm ([H|T]) -> max(max(H,hd(T)), max_norm(T)).
normalize(X)-> [ Y /max_norm(X) || Y <- X].

%J. [9] reimplement I. using "lists:map/2". 
normalize2(L) -> lists:map(fun(X) -> X / max_norm(L) end, L).

%K. [10] rewrite A. with only one clause and one use case expression.
sum2(L)->
  case L of
    []-> 0;
    L -> hd(L) + sum2 (tl(L))
  end.

%L. [11] Takes a list as argument, and returns his last element only. 
%If list is empty, then crashes.
%modify the below function, in order to make it simpler, and without using use case or if-expressions:
%last(Xs) ->
% if length(Xs) == 1 -> hd(Xs);
%     true            -> last(tl(Xs))
%  end.
last([X]) -> X;
last([]) -> exit([]);
last([_|Xs]) -> Xs, last(Xs).

%M. [12] Return the product of the elements of a given list.
%if the list is empty, the product is 1, otherwise it goes recursively through all the list, starting with the first
%element.
mul([]) ->1;
mul([L|Ls]) -> L * mul(Ls).

%N. [13] Given a specific predicate, find a value in a given list that satisfied the given predicate, 
%and return it with the atom "found, " preceding it,
%otherwise return "not_found".
find(Fun, L) -> X = [ {found, Res} || Res <-L,
     Fun(Res) == true], if X == [] -> not_found;
                                    true -> hd(X) end. 

%M. [14] sorts a given list of values ascendingly.
sort([]) -> [];
sort([Index|Ls])->
 sort([L || L <- Ls, L < Index]) ++ [Index] ++ sort([L || L <- Ls, L >= Index]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Dictionary

%A.
dict_new() -> not_implemented.
dict_get(_, _) -> not_implemented.
dict_put(_, _, _) -> not_implemented.

%B.
dict_wellformed(_) -> not_implemented.

%C.
dict_map_values(_, _) -> not_implemented.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Trees

%A.
tree_leaf() -> not_implemented.
tree_branch(_, _, _) -> not_implemented.
tree_deconstruct(_) -> not_implemented.
tree_wellformed(_) -> not_implemented.

%B.
tree_make_bfs(_) -> not_implemented.

%C.
tree_bind(_, _) -> not_implemented.
tree_flatten(_) -> not_implemented.
tree_dfs(_) -> not_implemented.
tree_sorted(_) -> not_implemented.
tree_find(_, _) -> not_implemented.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Digitify a number [15] 
%given a number N, write the digits in the numbers in the form of a list.
%All the possible cases of N have been considered with a "case clause", and 
%assigned the appropriate return statements.
digitize(N) ->
   case N  of
   	N when ( N == 0) -> exit(0); 
   	N when (N < 10) and (N >= 0) -> [N];
   	N when (N >=10) and (N > 0) -> digitize( N div 10) ++ [N rem 10];
   	N when (N< 0) -> exit(-1)
   end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Happy numbers

is_happy(_N) -> not_implemented.
all_happy(_N, _M) -> not_implemented.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Expressions

%A.
expr_eval(_Expr) -> not_implemented.

%B.
expr_print(_Expr) -> not_implemented.

