class Car

  attr_accessor :id, :make, :model, :engine

  def self.open_communication

    conn = PG.connect( dbname: 'cars' )

  end

  def save
    conn = Car.open_communication

    if !self.id
      sql = "INSERT INTO cars (make, model, engine) VALUES ('#{self.make}', #{self.model}, '#{self.engine}')"
    else
      sql = "UPDATE cars SET make='#{self.make}', model=#{self.model}, engine='#{self.engine}' WHERE id='#{self.id}'"
    end

    conn.exec(sql)

  end

  def self.all # self for class method
    conn = self.open_communication

    sql = "SELECT * FROM cars ORDER BY id"
    result = conn.exec(sql)

    cars = result.map do |car|
      self.hydrate car
    end
    cars

  end

  def self.find id
    conn = self.open_communication
    sql = "SELECT * FROM cars WHERE id=#{id}"
    results = conn.exec(sql)

    car = self.hydrate results[0]

    car

  end

  def self.destroy id
    conn = self.open_communication
    sql = "DELETE FROM cars WHERE id=#{id}"
    conn.exec(sql)

  end

  def self.hydrate car_data
    car = Car.new

    car.id = car_data['id']
    car.make = car_data['make']
    car.engine = car_data['engine']

    car
  end

end
