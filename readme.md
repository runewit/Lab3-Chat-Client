Lab2: Client/Server Program

To make this work, one must first get the server running before starting
	any client (hopefully obvious) and then the clients can be opened.

At the moment, there is no guard against multiple people entering the same
	name, so messages sent to that name will only go to one of them, though
	both can send messages out.  Also, my program expects only a command in
	all caps as the first input, then it will prompt the user for additional
	input.

There is really no testing for this program at the moment, though I intend
	to add useful tests to the test_server file and make a test_client file.