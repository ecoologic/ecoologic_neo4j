class Sql

  def self.execute_query(name, args)
    @@cypher_queries ||= begin
      puts "Reading cypher queries"
      YAML::load File.open './db/cypher_queries.yml'
    end
    NEO.execute_query @@cypher_queries[name.to_s], args
  end

end

