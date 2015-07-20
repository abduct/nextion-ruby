# nextion-ruby

This is a ruby class to parse the output of nextion screens and to create valid input for the screen.

In its current state it may be highly broken and not fit for any kind of use. At the momment it simply has callback support and parsing of messages.

The client.rb file holds the setup of the callbacks as well as the calling of the message parsing function. The expected output is:

String_Variable_Data callback
Header: 70
String: abc

Touch_Coordinate callback
Header: 67
X Coord: 122
Y Coord: 30
Touch event: 01
