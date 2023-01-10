# Note about algorithm over all
# To make it easier, a combo approach for the final version:
# Take the top 3 fastest paths and look up timetables for each
# Then take the fastest of those three
# This way we are not taking the timetable approach from the start, 
# far more complex as a primary strategy.

module GbTrainNetwork
  module Journey
    class Planner
      attr_reader :source_station, :target_station, :fastest_path
      def initialize(source_station:, target_station:, network:)
        @source_station = source_station
        @target_station = target_station
        @network = network
        @fastest_path = nil
      end

      def find_station(station_id)
        @network.find { |station| station.id == station_id }
      end

      def journey
        queue = [@source_station]
        visited = []

        until queue.empty?
          station = queue.shift
          station.connections.each do |station_id|
            connected_station = find_station(station_id)
            
            if connected_station.id == target_station.id
              return [source_station] + visited + [target_station]
            else
              queue << connected_station
              visited << connected_station
            end
          end
        end
      end
    end
  end
end

    # class Path
    #   def initialize(current_station)
    #     @path = [current_station]
        
    #   end

    #   def add_to_path(station)
    #     @path << station
    #   end
    # end


# https://en.wikipedia.org/wiki/Breadth-first_search

# It seems that this pseudocode does the trick

# However, it seems to be missing one thing that I will need

# Each enqueud node needs to know its trace back to the source node (ie a collection of other nodes)

# —

# At the time that the target is reached, 
# the trace’s total segment length is calculated, 
# and compared to the shortest length so far (if any). 
# If its shorter, the shortest up to that point is replaced.

# https://stackoverflow.com/questions/9535819/find-all-paths-between-two-graph-nodes


# ——

# Maybe I don’t need this. If we’re talking about a naive “find the shortest path”, 
# then tracking visited nodes globally is fine. The queue items need to keep items with path history though

    
    