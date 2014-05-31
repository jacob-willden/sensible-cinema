
module SensibleSwing
  
  class MainWindow
  
    def start_new_run *args
      update_playing_well_status 'initializing...'
      @close_proc.call if @close_proc # reset in case they call start twice
      @close_proc, @overlay = go_online *args
    end
    
    def setup_online_player_buttons
      require_relative '../online_movie_players.rb'	 
      add_text_line 'Online Player playback Options:'

      new_jbutton("Start edited playback") do
        start_new_run self
      end            

      new_jbutton("Stop edited playback") do
        @close_proc.call if @close_proc
      end            

      new_jbutton("Open Website for viewing/editing movie edit choices") do
         SimpleGuiCreator.open_url_to_view_it_non_blocking "http://cinemasoap.inet2.org"
      end	    
      @online_status_label = add_text_line "Player status:"
      @playing_well_label = add_text_line "Status: hit start to being..."
      @playing_well_label2 = add_text_line ""
      # add_open_documentation_button # not pertinent enough yet...	  
      if ARGV.contain?('--advanced')
      
        path = File.dirname(__FILE__) + "/../../zamples/players/amazon/total_length_over_an_hour.txt"
        autostart = new_jbutton("Auto start edited playback for testing") do
          url = "http://www.amazon.com/gp/product/B004RFZODC" # Island of grace amazon for now
          start_new_run self, false, url, path          
        end
        new_jbutton("Take screen snapshot of player descriptor") do
          start_new_run self, true, nil, path
        end
        new_jbutton("Reset current timestamp to 0:0s") do
          @overlay.timestamp_changed "0:0", 0
        end
        autostart.click!
      end
    end

    def update_playing_well_status status
      @playing_well_label.set_text "Status:" + status[0..50]
      if status.length > 50
        @playing_well_label2.set_text status[50..-1]
      else
        @playing_well_label2.set_text "" # reset it
      end
    end
    
    def update_online_player_status status
      @online_status_label.set_text "Player status:" + status
    end
  end
end
