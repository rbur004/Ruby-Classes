# Ruby-Classes

Ruby classes, with no specified parent, inherit from the 'Class' class. There is an instance class for each class we create. The instances we create in code, with .new(), are derived from these class instances. Variables can be created in these class instance classes, that get shared across the .new() instances we created, but not subclasses of our class.

Classes can inherit from any other class. They then share @@variables. They do not share the class specific variables, or the class level @variables.

Confused?

## @variable is unique to an instance of a class
`@variable` is visible to all methods in an instance of a class, but not across instances. 
In this case, instances created with `x = Test.new`
```
class Test
  attr_accessor variable # creates public methods to access @variable
  def initialize
    # Our class is 'Test'. We got here with Test.new
    @variable = 1.1 # ( Or Test.new.variable )
  end
  def self.mymethod
    # Our class is now 'Class'. It is not 'Test'. i.e Test is an instance of Class
    @variable == Null # i.e. it hasn't been defined
  end
end
```

## self.class.variable is global across all instances of class, but not subclasses

`self.class.variable` is visible across all instances of a class, but not instances of subclasses.
Within a class method, these variables can be referenced with @variable, as they are a class variable belonging to 
the instance of our class definition ( in this case the class Test itself ).
```
class Test
  class << self
    # Our class is now 'Class'. It is not 'Test'. i.e Test is an instance of Class
    # Defined at the class level, but not for classes inheriting from this class
    # Not the same as @account in a specific instance.
    attr_accessor :account  # provide class methods for reading/writing
  end
  def initialize
    # Our class is 'Test'. We got here with Test.new
    self.class.account = 1.2 # ( Or Test.account, as we created attr_accessor methods )
  end
  def self.mymethod
    # Our class is now 'Class'. It is not 'Test'. i.e Test is an instance of Class
    @account == 1.2 # ( in a class method, @account is not instance.account )
  end
end
```
## @@variable is global across all instances of the class, including subclasses

```
class Test
  attr_accessor variable # creates public methods to access @variable
  def initialize
    # Our class is 'Test'. We got here with Test.new
    @@variable = 1.3 # (  @@variable != self.class.account )
  end
  def self.mymethod
    # Our class is now 'Class'. It is not 'Test'. i.e Test is an instance of Class
    @@variable == 1.3 # i.e it is the same as using it in a standard method.
  end
end
```

