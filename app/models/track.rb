class Track < ApplicationRecord
    belongs_to :event, class_name: "Event", foreign_key: "events_id"
    has_many :lectures, class_name: "Lecture", foreign_key: "tracks_id", dependent: :destroy
    accepts_nested_attributes_for :lectures, allow_destroy: true

    def self.build_tracks(lectures)
             knapsack_lectures = ->(lectures, i){
                tracks = []
                knapsack = Knapsack.new(180)
                lectures.each do |lecture|
                    knapsack.add_item(KnapsackItem.new(lecture, lecture.time_duration.to_i))
                end 
                selected_lectures_by_morning = knapsack.knapsack_0_1

                Lecture.define_time_schedule_lectures(selected_lectures_by_morning, 'morning')

                unselected_items = knapsack.unselected_items

                knapsack = Knapsack.new(240)

                unselected_items.each do |lecture|
                    knapsack.add_item(KnapsackItem.new(lecture, lecture.time_duration.to_i))
                end 

                selected_lectures_by_afternoon = knapsack.knapsack_0_1

                Lecture.define_time_schedule_lectures(selected_lectures_by_afternoon, 'afternoon')


                track = Track.new
                track.title = "Track #{track.letter_track(i)}"
                lectures_of_track = selected_lectures_by_morning.concat(selected_lectures_by_afternoon)
                track.lectures = lectures_of_track
                tracks.push(track)
                unselected_items_for_another_track  = knapsack.unselected_items
                if unselected_items_for_another_track.count > 0
                    tracks.push(knapsack_lectures.call(unselected_items_for_another_track, i + 1))
                end
                tracks
                
            }
            tracks = knapsack_lectures.call(lectures, 1)
            tracks = tracks.flatten
            tracks 
    end 

    def letter_track(indice)
        if indice >= 1 && indice <= 26
          return ('a'.ord + indice - 1).chr.upcase
        else
          return nil  # Retorna nil se o índice estiver fora do intervalo válido.
        end
    end
      
end

class KnapsackItem
    attr_accessor :lecture, :value, :weight
  
    def initialize(lecture, weight)
      @lecture = lecture
      @weight = weight
      if @weight == 60
        @value = 160 
      elsif @weight == 45
        @value = 140
      elsif @weight == 30
        @value = 120
      else  
        @value = 0
      end
    end
  
    def value_per_weight
      @value.to_f / @weight
    end
  end
  
  class Knapsack
    def initialize(capacity)
      @capacity = capacity
      @items = []
    end
  
    def add_item(item)
      @items << item
    end
  
    def knapsack_0_1
      n = @items.length
      dp = Array.new(n + 1) { Array.new(@capacity + 1, 0) }
  
      (1..n).each do |i|
        (1..@capacity).each do |w|
          if @items[i - 1].weight <= w
            dp[i][w] = [dp[i - 1][w], dp[i - 1][w - @items[i - 1].weight] + @items[i - 1].value].max
          else
            dp[i][w] = dp[i - 1][w]
          end
        end
      end
  
      result = []
      w = @capacity
      (n.downto(1)).each do |i|
        if dp[i][w] != dp[i - 1][w]
          result << @items[i - 1].lecture
          w -= @items[i - 1].weight
        end
      end
  
      result.reverse
    end

    def unselected_items
        selected_items = knapsack_0_1
        unselected = @items.reject { |item| selected_items.include?(item.lecture) }
        unselected.map {|item| item.lecture}
    end
  
    def knapsack_fractional
      value_per_weight = @items.map.with_index { |item, i| [i, item.value_per_weight] }
      value_per_weight.sort_by! { |_, ratio| -ratio }
  
      total_value = 0.0
      knapsack = Array.new(@items.length, 0)
  
      value_per_weight.each do |item, ratio|
        if @items[item].weight <= @capacity
          knapsack[item] = 1
          total_value += @items[item].value
          @capacity -= @items[item].weight
        else
          fraction = @capacity.to_f / @items[item].weight
          knapsack[item] = fraction
          total_value += @items[item].value * fraction
          break
        end
      end
  
      [knapsack, total_value]
    end
  end