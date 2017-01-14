-module(assignment4_counter).

%% DO NOT CHANGE THE EXPORT STATEMENT!
-export([start/0, init/0, incr/1, fetch/1, reset/1, stop/1
        ]).
%% End of no-change area



%%Maria-Bianca Cindroi
%%assignment4. Problem 1 - Counter server

%%start: spawns a new server process and returns the process id. The init function is called and the server's state is thus initialized with the integer 0.
start() ->
  spawn(assignment4_counter, init,[])   
.
%%I created a server function that gets an argument called "count" used to count how many times the server has been called. 
%%The server receives a message, and through pattern matching it performs the needed operation.
server(Count)->		 
	receive 
        %%if the "incrMsg" is received, then recall the server with an incremented state
		{incrMsg} -> 
				server(Count+1);
        %%if the "fetchMsg" is received accompanied by the console id,then replies with  the number of counts in the server, and recall the unchanged server state(otherwise the process will stop).
        {fetchMsg, Sender_Pid} -> 
		 % io:fwrite("Fetch count is ~p ~n", [Count]),
            Sender_Pid!{reply,Count},
			server(Count);
        %%if the "resetMsg" is received, then reset the count by reinitializing the state of the server to 0
		{resetMsg} ->
				init();
        %%if the "stopMsg" is received, then return "ok"
		{stopMsg} -> ok
	end	
.

%%the "init" initializes the state of server to 0.
init() -> 
	server(0)
.

%%the "incr" sends a "incrMsg" message to increment the count, and returns ok
incr(Pid) -> 
       Pid!{incrMsg},
       ok
.

%%the "fetch" sends a "fetchMsg" message to fetch the count, and awaits for a reply from the server, and outputs it
fetch(Pid) -> 
   Sender_Pid=self(),
   Pid!{fetchMsg, Sender_Pid},
   receive 
     {reply,Count}-> Count
   end

.

%%the "reset" sends a "resetMsg" message to reset the count, and returns ok
reset(Pid) -> 
	Pid!{resetMsg},
    ok
.

%%the "stop" sends a "stopMsg" message to stop the process, and returns ok
stop(Pid) ->
	Pid!{stopMsg},
    ok
.
