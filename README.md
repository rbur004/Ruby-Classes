# Ruby-Classes

Ruby classes, with no specified parent, inherit from the 'class' class. There is an instance class for each class we create. The instances we create in code, with .new(), are derived from these class instances. Variables can be created in these class instance classes, that get shared across the .new() instances we created, but not subclasses of our class.

Classes can inherit from any other class. They then share @@variables. They do not share the class specific variables, or the class level @variables.

Confused?

## @variable is unique to an instance of a class
```
class Test
  attr_accessor variable # creates public methods to access @variable
  def initialize
    @variable = 1.1 # ( Or Test.new.variable )
  end
end
```

## self.class.variable is global across all instances of class, but not subclasses
```
class Test
  class << self
   # Defined at the class level, but not for classes inheriting from this class
    # Not the same as @account in a specific instance.
    attr_accessor :account  # provide class methods for reading/writing
  end
  def initialize
    self.class.account = 1.2 # ( Or Test.account, as we created attr_accessor methods )
  end
  def self.mymethod
    @account == 1.2 # ( in a class method, @account is not instance.account )
  end
end
```
## @@variable is global across all instances of the class, including subclasses
```
class Test
  attr_accessor variable # creates public methods to access @variable
  def initialize
    @@variable = 1.3 # (  @@variable != self.class.account )
  end
end
```

