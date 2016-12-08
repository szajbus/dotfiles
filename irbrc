begin
  require 'pry'
  Pry.start
rescue LoadError
  IRB.conf[:SAVE_HISTORY] = 200
  IRB.conf[:HISTORY_FILE] = '~/.irb_history'
end
