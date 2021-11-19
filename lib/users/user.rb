class User
  attr_reader :first_name, :last_name

  def initialize(first_name = 'Ivan', last_name = 'Petroff')
    @first_name, @last_name = first_name, last_name
  end

  def full_name
     [first_name, last_name].join(' ')
  end
end
