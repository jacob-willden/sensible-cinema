require 'rubygems' # ugh
require 'ffi'

module Muter
  # from msdn on keybd_event ...
  
  VK_VOLUME_DOWN = 0xAE
  VK_VOLUME_UP = 0xAF
  VK_VOLUME_MUTE = 0xAD
  KEYEVENTF_KEYUP = 2
  
  extend FFI::Library
  ffi_lib 'user32'
  ffi_convention :stdcall

  attach_function :keybd_event, [ :uchar, :uchar, :int, :pointer ], :void
  
  def hit_mute_key
    # simulate pressing the mute key
    keybd_event(VK_VOLUME_MUTE, 0, 0, nil)
    keybd_event(VK_VOLUME_MUTE, 0, KEYEVENTF_KEYUP, nil)
  end
  
  def hit_volume_up_key
    keybd_event(VK_VOLUME_UP, 0, 0, nil)
    keybd_event(VK_VOLUME_UP, 0, KEYEVENTF_KEYUP, nil)
  end
  
  def hit_volume_down_key
    keybd_event(VK_VOLUME_UP, 0, 0, nil)
    keybd_event(VK_VOLUME_UP, 0, KEYEVENTF_KEYUP, nil)
  end
  
  def mute!
    unmute! # just in case
    hit_mute_key
  end
  
  def unmute!
    hit_volume_down_key
    hit_volume_up_key
  end
      
  # allow for Muter.xxx
  extend self
  
end

if $0 == __FILE__
  # whacky test
  require 'benchmark'
  begin
    require 'hitimes'
    Benchmark.module_eval {
      def self.realtime
        Hitimes::Interval.measure { yield }
      end
    }
  rescue LoadError
    puts 'no hitimes available...'
  end
  Muter.mute!
  Muter.mute!
  puts 'silence'
  sleep 1
  Muter.unmute!
  puts 'non silence'
  sleep 1
  Muter.unmute!
  puts 'non silence'
  sleep 1
  puts 'single takes'
  p Benchmark.realtime { 1.times{Muter.hit_volume_down_key}}
  puts 'triple takes'
  p Benchmark.realtime { 1.times{Muter.unmute!}} # 0.00023848s
  # seems actually like reasonable speed

end