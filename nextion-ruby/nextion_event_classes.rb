class InvalidEvent
    def initialize(message)
        @event = message.match(/(..).{6}/)
    end
    
    def get_header
        @event[1]
    end
end

class TouchEvent
    def initialize(message)
        @event = message.match(/(..)(..)(..)(..).{6}/)
    end
    
    def get_header
        @event[1]
    end
    
    def get_page_id
        @event[2]
    end
    
    def get_component_id
        @event[3]
    end
    
    def get_touch_event
        @event[4]
    end
end

class CurrentPageId
    def initialize(message)
        @event = message.match(/(..)(..).{6}/)
    end
    
    def get_header
        @event[1]
    end
    
    def get_page_id
        @event[2]
    end
end

class TouchCoordinate
    def initialize(message)
        @event = message.match(/(..)(.{4})(.{4})(..).{6}/)
    end
    
    def get_header
        @event[1]
    end
    
    def get_x_coordinate
        @event[2].to_i(16)
    end
    
    def get_y_coordinate
        @event[3].to_i(16)
    end
    
    def get_touch_event
        @event[4]
    end
end

class StringVariableData
    def initialize(message)
        @event = message.match(/(..)(.*).{6}/)
    end
    
    def get_header
        @event[1]
    end
    
    def get_string
        [@event[2]].pack("H*")
    end
end

class NumericVariableData
    def initialize(message)
        @event = message.match(/(..)(.{16}).{6}/)
    end
    
    def get_header
        @event[1]
    end
    
    def get_number
        @event[2].scan(/.{8}/).map(&:reverse).join.to_i(16)
    end
end