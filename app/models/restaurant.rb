class Restaurant
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    location: "TEXT",
    owner_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def owner
    # return owner of this restaurant
    sql = <<-SQL
      SELECT restaurants.owner_id
      FROM restaurants
      INNER JOIN owner ON restaurants.owner_id = owner.id
      WHERE owner.id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end

  def customer
    # return customer of that review
    sql = <<-SQL
      SELECT reviews.customer_id
      FROM reviews
      INNER JOIN customer ON reviews.customer_id = customer.id
      WHERE customer.id = ?
    SQL
    self.class.db.execute(sql, self.id)

  end

  def restaurant
    sql = <<-SQL
      SELECT review.restaurant_id
      FROM reviews
      INNER JOIN restaurants ON reviews.restaurant_id = restaurant.id
      WHERE restaurant.id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end



end
