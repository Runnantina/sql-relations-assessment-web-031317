class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def restaurants
    # all restaurants to this owner
    sql = <<-SQL
      SELECT restaurants.owner_id
      FROM restaurants
      INNER JOIN owners ON owners.id = restaurants.owner_id
      WHERE restaurants.owner_id = ?
    SQL
    self.class.db.execute(sql, self.id)

  end
end
