#!/usr/bin/env ruby

#Note that we are deliberately using the same variable name for 
# an instance variable, a class specific variable, and a global variable
# so it is clear that while they have the same naming, they are distinct.
# Don't do this in practice, or you will get confused.

class Test
  attr_reader :account # Instance Specific variable.
  class << self
    # Defined at the class level, but not for classes inheriting from this class
    # Not the same as @account in a specific instance of our class.
    attr_accessor :account  # provide class Test instance methods for reading/writing
  end

  def initialize
    @account = 1.1 # Instance specific
  end

  def set_class_vars
    self.class.account = 1.2 # Global across all instances of the class Test, but not SubclassTest
    @@account = 1.3 # Global across all instances of Test and SubclassTest
  end

  def debug1
    puts "Instance method"
    puts "  I exist only in a specific instance of the class"
    puts "  @account = #{@account}"
    puts "  self.account = #{self.account}"
    puts
    begin
      puts "  I exist in a all instances of the class Test, but not subclasses of Test. I am not instance.@account"
      puts "  self.class.account = #{self.class.account}"
      puts "  Test.account = #{Test.account}"
      puts "  SubclassTest.account = #{SubclassTest.account}"
    rescue StandardError => e
      puts e
    end
    puts
    puts "  I am global for all instances of Test and get inherited by subclasses of Test"
    puts "  @@account=#{@@account} I am global and get inherited by subclasses"
  end

  def self.debug2
    puts "in self.method"
    begin
      puts "  I exist in a all instances of the class, but not subclasses. I am not instance.@account"
      puts "  @account = #{@account}"
      puts "  Test.account = #{Test.account}"
      puts "  SubclassTest.account = #{SubclassTest.account}"
    rescue StandardError => e
      puts e
    end
    puts
    puts "  @@account=#{@@account} I am global and get inherited"
  end

end

class SubclassTest < Test
  def initialize
    @account = 2.1
  end
end


st = Test.new
st.set_class_vars
st.debug1
puts
Test.debug2
puts
puts SubclassTest
sst = SubclassTest.new
sst.debug1
SubclassTest.debug2
puts
puts "st.account = #{st.account}"
puts "set SubclassTest.account = 1.4 to prove it is not Test.account"
SubclassTest.account = 1.4
puts "Test.account = #{Test.account}"
puts "SubclassTest.account = #{SubclassTest.account}"
puts "Test::account = #{Test::account}"
puts "Test @@account #{Test.class_variable_get(:@@account)}"
