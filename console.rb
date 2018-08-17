require_relative('models/ticket.rb')
require_relative('models/screening.rb')
require_relative('models/film.rb')
require_relative('models/customer.rb')

require('pry-byebug')

Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'Doot Dootman', 'funds' => 200})
customer2 = Customer.new({'name' => 'Bob Boberton', 'funds' => 80})
customer3 = Customer.new({'name' => 'Jennifer Jennings', 'funds' => 100})

customer1.save()
customer2.save()
customer3.save()

film1 = Film.new({'title' => 'Dootmaster', 'price' =>  10})
film2 = Film.new({'title' => 'Dootmaster 2: Electric Dootaloo', 'price' => 10})
film3 = Film.new({'title' => 'Dead Bob', 'price' => 5})
film4 = Film.new({'title' => 'Space IN SPACE', 'price' => 20})

film1.save()
film2.save()
film3.save()
film4.save()

screening1 = Screening.new({'film_id' => film1.id, 'showing' => '20:00', 'tickets_left' => 100})
screening2 = Screening.new({'film_id' => film2.id, 'showing' => '22:00', 'tickets_left' => 100})
screening3 = Screening.new({'film_id' => film3.id, 'showing' => '18:30', 'tickets_left' => 50})
screening4 = Screening.new({'film_id' => film4.id, 'showing' => '19:15', 'tickets_left' => 150})

screening1.save()
screening2.save()
screening3.save()
screening4.save()

ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer1.id, 'fee' => film1.price})
ticket2 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer1.id, 'fee' => film2.price})
ticket3 = Ticket.new({'film_id' => film3.id, 'customer_id' => customer2.id, 'fee' => film3.price})
ticket4 = Ticket.new({'film_id' => film4.id, 'customer_id' => customer3.id, 'fee' => film4.price})
ticket5 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer3.id, 'fee' => film2.price})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()

binding.pry
nil
