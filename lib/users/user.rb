class User
  attr_reader :first_name, :last_name

  def initialize(first_name = 'Ivan', last_name = 'Petroff')
    raise ArgumentError, 'Please, provide non blank first_name' if ['', nil].include?(first_name)

    @first_name, @last_name = first_name, last_name
  end

  def full_name
    ([first_name, last_name] - ['', nil]).join(' ')
  end
end
