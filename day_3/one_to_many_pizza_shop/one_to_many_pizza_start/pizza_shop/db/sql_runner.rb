require('pg')

class SqlRunner
  def self.run(sql, values = [])
    begin #code to run
      db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure #makes sure the next bit runs even if previous does not.
      db.close() if db != nil
    end #this ends the begin/ensure/end
    return result
  end
end
