class Nextion
    def initialize
        @event_handle_storage = {}
        @events_table = {
                        "00" => "invalid_instruction",
                        "01" => "successful_execution",
                        "03" => "invalid_page_id",
                        "04" => "invalid_picture_id",
                        "05" => "invalid_font_id",
                        "1a" => "invalid_variable_name",
                        "1b" => "invalid_variable_operation",
                        "65" => "touch_event",
                        "66" => "current_page_id",
                        "67" => "touch_coordinate",
                        "68" => "sleep_touch_event",
                        "70" => "string_variable_data",
                        "71" => "numeric_variable_data"
                        }
    end
    
    def return_fixed_event(event)
        return @events_table[event]
    end
    
    def add_event(event, &block)
        begin
            if !@events_table.has_value?(event)
                raise "(Nextion-Ruby - add_event) Invalid event"
            elsif !block_given?
                raise "(Nextion-Ruby - add_event) Invalid block given"
            end
            
            @event_handle_storage[event] = block
        rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
        end
    end
    
    def return_event_handle(event)
        begin
            event_handle = @event_handle_storage[event]
            
            if event_handle != nil
                if event_handle.arity != 1
                    raise "(Nextion-Ruby - return_event_handle) Event has a invalid number of arities in block"
                end
            end
             
             return event_handle
        rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
        end
    end
    
    def generate_event_class(event, event_message)
        begin
            case event
                when "invalid_instruction"
                    return InvalidEvent.new(event_message)
                when "successful_execution"
                    return InvalidEvent.new(event_message)
                when "invalid_page_id"
                    return InvalidEvent.new(event_message)
                when "invalid_picture_id"
                    return InvalidEvent.new(event_message)
                when "invalid_font_id"
                    return InvalidEvent.new(event_message)
                when "invalid_variable_name"
                    return InvalidEvent.new(event_message)
                when "invalid_variable_operation"
                    return InvalidEvent.new(event_message)
                when "touch_event"
                    return TouchEvent.new(event_message)
                when "current_page_id"
                    return CurrentPageId.new(event_message)
                when "touch_coordinate"
                    return TouchCoordinate.new(event_message)
                when "sleep_touch_event"
                    return TouchCoordinate.new(event_message)
                when "string_variable_data"
                    return StringVariableData.new(event_message)
                when "numeric_variable_data"
                    return NumericVariableData.new(event_message)
            end
        rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
        end
    end
    
    def parse_message(message)
    event = self.return_fixed_event(message[0].unpack("H*")[0])
    event_handle = self.return_event_handle(event)
    if event_handle != nil
        event_class = self.generate_event_class(event, message.unpack("H*")[0])
        event_handle.call(event_class)
    end
end
end

