-module(assignment5_store).


%%Maria-Bianca Cindroi
%%Assginment5 - Problem 3 - Automatic cleanup for the storage
%% DO NOT CHANGE THE EXPORT STATEMENT!
-export([start/0, init/0, stop/0, store/2, fetch/1, flush/0, supervisor/1
        ]).
%% End of no-change area

%%Maria-Bianca Cindroi
%%assignment5. Problem 3 - Automatic cleanup for the storage server

start() -> 
	case whereis(sts) of
	%%start a new process and register it "sts"
		undefined -> Pid =  spawn(assignment5_store, init, []),
							register(sts, Pid), {ok, Pid};
%if "sts" is already running, return its process id
		Pid -> {ok, Pid}
	end
.

%initialise a new process on a pid that is being registered as "sts", and an empty list	
init() -> server([])
.


supervisor(Pid) ->
  %supervisor function waits for the reply in which the process goes "off", and then flushes its data 
  spawn(fun()-> erlang:monitor(process,Pid),
		receive _ -> sts ! {Pid, flush} 
		end
	 end)
.

%%server()/1 receives list of commands meant to be performed on "sts"
server(List) ->
	receive	
	    {Pid, {store, Key, Value}}  ->
			case proplists:get_value({Pid, Key}, List) of
				undefined -> Pid ! {ok, no_value}, spawn(assignment5_store, supervisor, [Pid]);
				V -> Pid ! {ok, V}
			end,
   		          server([{{Pid, Key}, Value}] ++ proplists:delete({Pid,Key},List));
  
		  %if the key has not been used before, then return no value
	    {Pid, {fetch, Key}}  ->
      			case proplists:get_value({Pid, Key}, List) of
      				undefined -> Pid ! {error, not_found},spawn(assignment5_store, supervisor, [Pid]);
     				 V -> Pid ! {ok, V}
      			end,
      			  server(List);
	    {Pid, flush} -> NewList =[ {{Temp, Key},Value} || {{Temp, Key},Value} <- List, Temp =/= Pid],
	      		    Pid ! {ok,flushed},
	                    server(NewList)
  end
.

%stop "sts" or check if it has already been stopped and output accordingly
stop() ->
	case whereis(sts) of
		undefined -> already_stopped;
		Pid -> exit(Pid,dead), stopped
	end
.

%send the "store" message
store(Key, Value) -> sts ! {self(), {store, Key, Value}},
  receive
    Msg -> Msg
  end
.
	
%send the fetch message
fetch(Key) -> sts ! {self(), {fetch, Key}},
	receive	
		Msg -> Msg
	end
.

%flush the information stored on the registered process "sts"
flush() -> sts ! {self(),flush},
  receive
    {ok,flushed} -> {ok,flushed}
  end
.
