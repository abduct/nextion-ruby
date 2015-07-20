require "./nextion-ruby/nextion"
require "./nextion-ruby/nextion_event_classes"

nextion = Nextion.new

nextion.add_event("string_variable_data") do |event|
    puts "String_Variable_Data callback"
    puts "Header: #{event.get_header}"
    puts "String: #{event.get_string}"
    puts
end

nextion.add_event("touch_coordinate") do |event|
    puts "Touch_Coordinate callback"
    puts "Header: #{event.get_header}"
    puts "X Coord: #{event.get_x_coordinate}"
    puts "Y Coord: #{event.get_y_coordinate}"
    puts "Touch event: #{event.get_touch_event}"
    puts
end

#---------------------------------------
#Simple parsing for testing
message1 = "\x70\x61\x62\x63\xFF\xFF\xFF"
message2 = "\x67\x00\x7A\x00\x1E\x01\xFF\xFF\xFF"
nextion.parse_message(message1)
nextion.parse_message(message2)