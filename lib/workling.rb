module Workling
  class WorklingError < StandardError; end
  class WorklingNotFoundError < WorklingError; end

  mattr_accessor :load_path
  @@load_path = File.expand_path(File.join(File.dirname(__FILE__), '../../../../app/workers')) 
  
  #
  # determine the runner to use if nothing is specifically set. workling will try to detect
  # starling, spawn, or bj, in that order. if none of these are found, notremoterunner will
  # be used. 
  #
  # this can be overridden by setting Workling::Remote.dispatcher, eg:
  #   Workling::Remote.dispatcher = Workling::Remote::Runners::StarlingRunner.new
  #
  def self.default_runner
    if Object.const_defined? "Starling"
      Workling::Remote::Runners::StarlingRunner.new
    elsif Object.const_defined? "Spawn" # the spawn plugin is installed. 
      Workling::Remote::Runners::SpawnRunner.new
    elsif Object.const_defined? "Bj" # the backgroundjob plugin is installed. 
      Workling::Remote::Runners::BackgroundjobRunner.new
    else
      Workling::Remote::Runners::NotRemoteRunner.new
    end
  end
  
  #
  # gets the worker instance, given a class. the optional method argument will cause an 
  # exception to be raised if the worker instance does not respoind to said method. 
  #
  def self.find(clazz, method = nil)
    begin
      inst = clazz.to_s.camelize.constantize.new 
    rescue NameError
      raise_not_found(clazz, method)
    end
    raise_not_found(clazz, method) if method && !inst.respond_to?(method)
    inst
  end
  
  private
    def self.raise_not_found(clazz, method)
      raise Workling::WorklingNotFoundError.new("could not find #{ clazz }:#{ method } workling. ") 
    end
end