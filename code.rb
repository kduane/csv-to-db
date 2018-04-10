require 'pg'
require 'csv'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

# your code, here

#import data from the CSV file
db_connection do |conn|
  CSV.foreach("ingredients.csv") do |row|
    ingredient = row[1]
    # export to PSQL database
    conn.exec_params(
      'INSERT INTO ingredients (ingredient) VALUES ($1)',
      [ingredient]
    )
  end
end

# pull from database & output on screen
ingredients = db_connection do |conn|
  conn.exec('SELECT id, ingredient FROM ingredients')
end

ingredients.to_a.each do |item|
  puts "#{item["id"]}. #{item["ingredient"]} \n"
  # binding.pry
end
