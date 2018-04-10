require 'pg'
require 'csv'

def db_connection
  begin
    connection = PG.connect(dbname: "")
    yield(connection)
  ensure
    connection.close
  end
end

# your code, here

#import data from the CSV file
db_connection do |conn|
  CSV.foreach("ingredients.csv", a+) do |row|
    ingredient = row[1]
    # export to PSQL database
    conn.exec_params(
      'INSERT INTO ingredients (ingredient) VALUES ($1)',
      [ingredient]
    )
  end
end

# pull from database & output on screen
db_connection do |conn|
