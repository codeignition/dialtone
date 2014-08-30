class CallController < ApplicationController
  def run
     call.auto_hangup = false
  end
end
