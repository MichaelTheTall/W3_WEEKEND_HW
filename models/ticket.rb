require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :fee

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @fee = options['fee'].to_i
  end

  def self.map_items(ticket_data)
    result = ticket_data.map { |e| Ticket.new(e)  }
    return result
  end

  def save()
    sql = "
      INSERT INTO tickets(
      customer_id,
      film_id,
      fee)
      VALUES(
      $1, $2, $3)
      RETURNING id"
    values = [@customer_id, @film_id, @fee]
    ticket = SqlRunner.run( sql,values ).first
    @id = ticket['id'].to_i

    sql2 = "UPDATE customers SET funds  = funds - $2 WHERE id = $1"
    values2 = [@customer_id, @fee]
    SqlRunner.run(sql2,values2)

    sql3 = "UPDATE screenings SET tickets_left = tickets_left - 1 WHERE id = $1"
    values3 = [@film_id]
    SqlRunner.run(sql3, values3)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return self.map_items(tickets)
  end

  def update()
    sql = "UPDATE tickets
    SET(
    customer_id, film_id, fee
    ) = (
    $1, $2, $3
    )
    WHERE id = $4"
    values=[@customer_id, @film_id, @fee, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values=[@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def film()
    sql = "SELECT * FROM films
    WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end

  def customer()
    sql = "SELECT * FROM customers
    WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

end
