-module(assignment4).

%% DO NOT CHANGE THE EXPORT STATEMENT!
-export([task/1, dist_task/1, pmap/2, faulty_task/1
        ]).
%% End of no-change area



%%Maria-Bianca Cindroi
%%assignment4. Problem 3 - Process handling
%%

%% Do not change the following two functions!
task(N) when N < 0; N > 100 ->
    exit(parameter_out_of_range);
task(N) ->
    timer:sleep(N * 2),
    256 + 17 *((N rem 13) + 3).

faulty_task(N) when N < 0; N > 100 ->
    exit(parameter_out_of_range);
    
faulty_task(N) ->
    timer:sleep(N * 2),
    {_,_,X} = now(),
    case X rem 10 == 0 of
        false ->
            256 + 17 *((N rem 13) + 3);
        true  ->
            throw(unexpected_error)
    end.
%% End of no-change area

%spawn a process for each computation and gather all the computation results in a list
dist_task(L) ->
  Pid = self(),
  List = [ spawn(fun() -> Pid ! {self(),task(N)} end) || N <- L],
    [receive
     	{Pid, N} -> N
     end || Pid <- List]
.


%each function application is evaluated in a separate process
%with the first argument being the function to apply and the second argument
%being the list of data
pmap(Function, L) ->
  Pid = self(),
  List = [ spawn(fun() -> Pid ! {self(),catch(Function(N))} end) || N <- L],
    [receive 
    	{Pid, N} -> N
     end || Pid <- List]
.
