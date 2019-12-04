require('pg')

class PizzaOrder

  attr_accessor :topping, :quantity
  attr_reader :id, :customer_id


  def initialize(options)
    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @id = options['id'].to_i if options ['id']
    @customer_id = options['customer_id'].to_i
  end

  def save()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "INSERT INTO pizza_orders
    (
      topping,
      quantity,
      customer_id
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@topping, @quantity, @customer_id]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    sql = "
    UPDATE pizza_orders SET (
      topping,
      quantity,
      customer_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@topping, @quantity, @customer_id, @id]
    result = dSqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM pizza_orders where id = $1"
    values = [@id]
    result = dSqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM pizza_orders WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    results = SqlRunner.run(sql)
    return orders.map{|id| PizzaOrder.new(order)}
  end

  def self.delete_all()
    sql = "DELETE FROM pizza_orders"
    result = SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM pizza_orders"
    result = SqlRunner.run(sql)
    return orders.map {|order| PizzaOrder.new(order)}
  end

end
