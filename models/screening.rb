require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :showing, :tickets_left

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @showing = options['showing']
    @tickets_left = options['tickets_left'].to_i
  end

  def self.map_items(screening_data)
    result = screening_data.map { |e| Screening.new(e)  }
    return result
  end

  def save()
    sql = "
      INSERT INTO screenings(
      film_id,
      showing,
      tickets_left)
      VALUES(
      $1, $2, $3)
      RETURNING id"
    values = [@film_id, @showing, @tickets_left]
    screening = SqlRunner.run( sql,values ).first
    @id = screening['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    list = SqlRunner.run(sql)
    return self.map_items(list)
  end

  def update()
    sql = "UPDATE screenings
    SET(
    film_id, showing, tickets_left
    ) = (
    $1, $2, $3
    )
    WHERE id = $4"
    values=[@film_id, @showing, @tickets_left, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values=[@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  # def ticket_sold(num)
  #   sql = "UPDATE screenings SET tickets_left = tickets_left - $2 WHERE id = $1"
  #   values = [@film_id, num]
  #   SqlRunner.run(sql, values)
  # end

  def customer()
    sql = "SELECT * FROM customers
    WHERE id = $1"
    values = [@showing]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  # def self.show()
  #   sql = "SELECT films.title
  #   FROM films
  #   INNER JOIN screenings
  #   ON screenings.film_id = films.id
  #   WHERE screenings.film_id = $1"
  #   values = [@id]
  #   return SqlRunner.run(sql, values)
  #   # return Customer.map_items(customers)
  # end

end
