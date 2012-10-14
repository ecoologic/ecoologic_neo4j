class Sql

  def self.execute_query(name, args = {})
    @@cypher_queries ||= load!
    $neo.execute_query @@cypher_queries[name.to_s], args
  end

private

  def self.load!
    puts "Reading cypher queries"
    YAML::load File.open './db/cypher_queries.yml'
  end

end

