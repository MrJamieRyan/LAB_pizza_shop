class PropertyTracker

require('PG')

attr_reader :id
attr_accessor :address, :value, :number_of_bedrooms, :year_built

def initialize(options)
  @id = options['id'].to_i() if options['id']
  @address = options['address']
  @value = options['value'].to_i()
  @number_of_bedrooms = options['number_of_bedrooms'].to_i()
  @year_built = options['year_built']
end


def save()
  db = PG.connect({dbname: 'property_shop', host: 'localhost'})
  sql = "INSERT INTO  property_tracker (
  address,
  value,
  number_of_bedrooms,
  year_built
  ) VALUES ($1, $2, $3, $4) RETURNING id;"
  values = [@address, @value, @number_of_bedrooms, @year_built]
  db.prepare("save", sql)
  @id = db.exec_prepared("save", values)[0]['id'].to_i()
  db.close()
end

def PropertyTracker.all()
    db = PG.connect({dbname: 'property_shop', host: 'localhost'})
    sql = "SELECT * FROM property_tracker;"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close
    return properties.map {|properties_hash| PropertyTracker.new(properties_hash)}
end

def update
  db = PG.connect({dbname: 'property_shop', host: 'localhost'})
  sql = "UPDATE property_tracker SET (
  address,
  value,
  number_of_bedrooms,
  year_built
  ) = (
  $1, $2, $3, $4 ) WHERE id = $5;"
  values = [@address, @value, @number_of_bedrooms, @year_built, @id]
  db.prepare("update", sql)
  db.exec_prepared("update", values)
  db.close
end

def delete()
  db = PG.connect({dbname: 'property_shop', host: 'localhost'})
  sql = "DELETE FROM property_tracker WHERE id = $1;"
  values = [@id]
  db.prepare("delete", sql)
  db.exec_prepared("delete", values)
  db.close
end

def PropertyTracker.find()
  db = PG.connect({dbname: 'property_shop', host: 'localhost'})
  sql = "SELECT * FROM property_tracker WHERE id = $1;"
  values = [@id]
  db.prepare("find", sql)
  specific_property = db.exec_prepared("find", values)
  db.close
  return specific_property.find { |property| PropertyTracker.new(property)}
end

end
