require_relative("../db/sql_runner")

class Film


  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def self.map_items(film_data)
    result = film_data.map { |e| Film.new(e)  }
    return result
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    return self.map_items(films)
  end

  def update()
    sql = "UPDATE films
    SET(
    title, price
    ) = (
      $1, $2
    )
    WHERE id = $3"
    values=[@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values=[@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return Customer.map_items(customers)
  end

  def number_of_customers()
    list = self.customers()
    return list.count
  end

  def popular()
    sql = "SELECT * FROM screenings WHERE screenings.film_id = $1 ORDER BY tickets_sold DESC LIMIT 1"
    values = [@id]
    # return SqlRunner.run(sql, values)
    list = SqlRunner.run(sql, values)
    return "The most popular time to see this film is #{Screening.map_items(list)[0].showing}!"
  end

end
