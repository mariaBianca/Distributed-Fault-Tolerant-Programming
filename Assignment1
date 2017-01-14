-module(assignment1).

-export([even_odd/1, range_overlap/2, rect_overlap/2,
         get_amp/1, f2c/1, c2f/1, convert/1,
         measure/3, any_2_equal/3]).

%%Maria-Bianca Cindroi 
%%DIT027 H16 Distributed Fault-Tolerant Programming
%%Assignment 1

% 2. Basic functions
% -----------------------
%A. return even when an even number, otherwise odd.
even_odd(X) when X rem 2 == 0 -> even;
even_odd(X) when X rem 2 /= 0 -> odd.

% -----------------------
%B.Check the range that is overlapped between 2 tuples.
%if no common point, or only one common point
range_overlap({_A,B},{C,_D}) when (B == C) orelse (B < C) -> no_overlap;
%if the second tuple represents bigger numbers than the first, but there are no common areas
range_overlap({A,_B},{_C,D}) when (A > D) orelse (D == A) -> no_overlap;
%otherwise overlap over the maximum between the minimal value, and the minimum between the maximal value.
range_overlap({A,B},{C,D})  -> {overlap,{max(A,C),min(B,D)}}.

%%C. extra
rect_overlap(_, _) -> ok.

% -----------------------
%D.Take the description of an amplification circuit and return 
%its amplification factor.

get_amp({amplifier, P,F,_N}) when element(2, P) > 0 -> F+element(2,P);
get_amp({amplifier, _P,F,_N}) -> F.


% -----------------------
%% E. Convert Fahrenheit to Celsius or vice-versa.
f2c(X) -> (X - 32) * 5/9.
c2f(X) -> X * 9/5 + 32.

% -----------------------
%% F. "Convert" converts from Fahrenheit to Celsius, and vice-versa.
convert({f, X}) -> {c, (X - 32) *5/9};
convert({c, X}) -> {f, X * 9/5 + 32}.


% Part 3
% -----------------------
%%A. The "measure" function non-linearly.
%measure(2, 5, 5) ? 3

measure(X,N,N) -> X+1;
measure(X,N,M) -> X+N-M.

% -----------------------
%%B.Check if there are any 2 arguments that are equal non-linearly.
any_2_equal(A, A, _B) -> true;
any_2_equal(A,_B,A) -> true;
any_2_equal(_B,A,A) -> true;
any_2_equal(_A,_B,_C) -> false.



