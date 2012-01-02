require 'java'

require 'sane'

module SensibleSwing
  
  class MainWindow < javax.swing.JFrame
    
	 
    def force_accept_license_first
      if !(LocalStorage['main_license_accepted'] == VERSION)
        require_blocking_license_accept_dialog 'Sensible Cinema', 'gplv3', 'http://www.gnu.org/licenses/gpl.html', 'Sensible Cinema license agreement', 
            "Sensible Cinema is distributed under the gplv3 (http://www.gnu.org/licenses/gpl.html).\nBY CLICKING \"accept\" YOU SIGNIFY THAT YOU HAVE READ, UNDERSTOOD AND AGREED TO ABIDE BY THE TERMS OF THIS AGREEMENT"
        require_blocking_license_accept_dialog 'Sensible Cinema', 'is_it_legal_to_copy_dvds.txt file', File.expand_path(File.dirname(__FILE__) + "/../../documentation/is_it_legal_to_copy_dvds.txt"), 
            'is_it_legal_to_copy_dvds.txt file', 'I acknowledge that I have read, understand, accept and agree to abide by the implications noted in the documentation/is_it_legal_to_copy_dvds.txt file'
        if JOptionPane.show_select_buttons_prompt("Would you like to use this with Zoom Player MAX's scene cuts [3rd party player program, costs $], or just MPlayer [free]", :yes => "ZoomPlayer MAX", :no => "Just MPlayer") == :yes
          LocalStorage['have_zoom_button'] = true
        end
        LocalStorage['main_license_accepted'] = VERSION
      end
    end
   
    def self.download full_url, to_here
      require 'open-uri'
      require 'openssl'
      eval("OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE") if full_url =~ /https/
      keep_going_bg_thread = true
	  print 'working'
      Thread.new { while keep_going_bg_thread; print '.'; sleep 1; end}
      writeOut = open(to_here, "wb")
      writeOut.write(open(full_url).read)
      writeOut.close
      keep_going_bg_thread = false
    end
    
    def self.download_to_string full_url
       require 'tempfile'
       to = Tempfile.new 'abc'
       download(full_url, to.path)
       out = File.binread(to.path)
       to.delete
       out
    end


    def download_7zip
      Dir.mkdir('./vendor/cache') unless File.directory? 'vendor/cache' # development may not have it created yet... [?]
      unless File.exist? 'vendor/cache/7za.exe'
        Dir.chdir('vendor/cache') do
          print 'downloading unzipper (7zip--400K) ...'
          MainWindow.download("http://downloads.sourceforge.net/project/sevenzip/7-Zip/9.20/7za920.zip", "7za920.zip")
          system_blocking("../unzip.exe -o 7za920.zip") # -o means "overwrite" without prompting
        end
      end
    end
    
    def download_zip_file_and_extract english_name, url, to_this
      download_7zip
      Dir.chdir('vendor/cache') do
        file_name = url.split('/')[-1]
        print "downloading #{english_name} ..."
        MainWindow.download(url, file_name)
        system_blocking("7za e #{file_name} -y -o#{to_this}")
        puts 'done ' + english_name
        # creates vendor/cache/mencoder/mencoder.exe...
      end
    end
    
    def check_for_exe windows_full_loc, unix_name
      # in windows, that exe *at that location* must exist...
      if OS.windows?
        File.exist?(windows_full_loc)
      else
        require 'lib/check_installed_mac.rb'
        if !CheckInstalledMac.check_for_installed(unix_name)
          exit 1 # it'll have already displayed a message...
        else
          true
        end
      end
    end
	
	def check_for_file_manipulation_dependencies
	
	   if !check_for_exe('vendor/cache/mencoder/mencoder.exe', 'mencoder') # both use it now, since we have to use our own mplayer.exe for now...
        require_blocking_license_accept_dialog 'mplayer', 'gplv2', 'http://www.gnu.org/licenses/gpl-2.0.html', "Appears that you need to install a dependency: mplayer with mencoder."
        download_zip_file_and_extract "Mplayer/mencoder (6MB)", "http://sourceforge.net/projects/mplayer-win32/files/MPlayer%20and%20MEncoder/revision%2034118/MPlayer-rtm-svn-34118.7z", "mencoder"
        old = File.binread 'vendor/cache/mencoder/mplayer.exe'
        old.gsub! "V:%6.1f", "V:%6.2f" # better precision! :)
        File.binwrite('vendor/cache/mencoder/mplayer.exe', old)
      end
    end
    
    def check_for_various_dependencies
            
      if OS.doze? && !check_for_exe('vendor/cache/mplayer_edl/mplayer.exe', nil)
        require_blocking_license_accept_dialog 'Mplayer-EDL', 'gplv2', 'http://www.gnu.org/licenses/gpl-2.0.html', "Appears that you need to install a dependency: mplayer EDL "
        FileUtils.mkdir_p 'vendor/cache/mplayer_edl'
        puts 'downloading mplayer edl [10 MB]'
        MainWindow.download('http://sourceforge.net/projects/mplayer-edl/files/mplayer.exe', 'vendor/cache/mplayer_edl/mplayer.exe')
		config_dir = File.expand_path('~/mplayer')
		FileUtils.mkdir(config_dir) unless File.directory?(config_dir)
		FileUtils.cp('vendor/subfont.ttf', config_dir) # TODO mac
      end

      # runtime dependencies, at least as of today...
      ffmpeg_exe_loc = File.expand_path('vendor/cache/ffmpeg/ffmpeg.exe') # I think file basd normal needs ffmpeg
      if !check_for_exe(ffmpeg_exe_loc, 'ffmpeg')
        require_blocking_license_accept_dialog 'ffmpeg', 'gplv2', 'http://www.gnu.org/licenses/gpl-2.0.html', "Appears that you need to install a dependency: ffmpeg."
        download_zip_file_and_extract "ffmpeg (5MB)", "http://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-git-335bbe4-win32-static.7z", "ffmpeg"
      end
      if OS.mac?
        check_for_exe("mplayer", "mplayer") # mencoder and mplayer are separate for mac... [this checks for mac's mplayerx, too]
      else      
        path = RubyWhich.new.which('smplayer')
        if(path.length == 0)
          # this one has its own installer...
		      require_blocking_license_accept_dialog 'Smplayer', 'gplv2', 'http://www.gnu.org/licenses/gpl-2.0.html', "Appears that you need to install a dependency: smplayer."
     		  save_to_dir = SwingHelpers.new_existing_dir_chooser_and_go 'pick dir to save smplayer exe installer to:'
		      save_to_file =  "#{save_to_dir}/smplayer-0.6.9-win32.exe"
    		  puts "downloading smplayer.exe [14MB] to #{save_to_file}"
          MainWindow.download "http://sourceforge.net/projects/smplayer/files/SMPlayer/0.6.9/smplayer-0.6.9-win32.exe", save_to_file
		      show_blocking_message_dialog "Run this file to install it (ok to reveal): smplayer-0.6.9-win32.exe"
    		  show_in_explorer save_to_file
          sleep 2
		      show_blocking_message_dialog "hit ok after smplayer is installed:"
        end
      end
    end
    
    def assert_ownership_dialog 
      message = "Do you certify you own the DVD this came of and have it in your possession, if it came from a DVD?"
      title = "Verify ownership"
      returned = JOptionPane.show_select_buttons_prompt(message, {:yes => "no", :no => "yes"})
      assert_confirmed_dialog returned, nil
    end
  
    def require_blocking_license_accept_dialog program, license_name, license_url_should_also_be_embedded_by_you_in_message, 
      title = 'Confirm Acceptance of License Agreement', message = nil
      puts 'Please confirm license agreement in open window before proceeding.'
      
      message ||= "Sensible Cinema requires a separately installed program (#{program}), not yet installed.
        You can install this program manually to the vendor/cache subdirectory, or Sensible Cinema can download it for you.
        By clicking accept, below, you are confirming that you have read and agree to be bound by the
        terms of its license (the #{license_name}), located at #{license_url_should_also_be_embedded_by_you_in_message}.  
        Click 'View License' to view it.  If you do not agree to these terms, click 'Cancel'.  You also agree that this is a 
        separate program, with its own distribution, license, ownership and copyright.  
        You agree that you are responsible for the download and use of this program, within sensible cinema or otherwise."
      answer = JOptionPane.show_select_buttons_prompt message, :no => "I have read and Accept the terms of the #{license_name} License Agreement.", :yes => "View #{license_name}"
      assert_confirmed_dialog answer, license_url_should_also_be_embedded_by_you_in_message
      p 'confirmation of sensible cinema related license duly noted of: ' + license_name # LODO require all licenses together :P
    end
    
    def assert_confirmed_dialog returned, license_url_should_also_be_embedded_by_you_in_message
      # :yes is "view license", :no is "accept", :cancel
      if returned == :yes
        if license_url_should_also_be_embedded_by_you_in_message
          SwingHelpers.open_url_to_view_it_non_blocking license_url_should_also_be_embedded_by_you_in_message
          puts "Please restart after reading license agreement, to be able to then accept it."
        else
          puts 'dialog assertion failed'
        end
        System.exit 0
      elsif returned == :cancel
        p 'license not accepted...exiting'
        System.exit 1
      elsif returned == :exited
        p 'license exited early...exiting'
        System.exit 1
      elsif returned == :no
        # ok
      else
        raise 'unknown?'
      end
    end
  end
end
