=begin
Copyright 2010, Roger Pack 
This file is part of Sensible Cinema.

    Sensible Cinema is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Sensible Cinema is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Sensible Cinema.  If not, see <http://www.gnu.org/licenses/>.
=end
require 'Win32API'

# does the jruby check inline

class StatusLine

 def initialize fella
  @fella = fella
 end

 def start_thread
  Thread.new { 
    loop {
      p 'status line thread'
      print get_line_printout
      sleep 0.1
    } 
   }
 end

 def get_line_printout
    status = @fella.status
    # some scary hard coded values here...XXXX
    " " * 20 + "\b"*150 + status
 end

end