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
