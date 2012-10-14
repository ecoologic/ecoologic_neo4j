class EcoologicNeo4j < Sinatra::Base

  set :static, true
  set :public_folder, File.dirname(__FILE__) + '/public'

  get '/stylesheets/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"stylesheets/#{params[:name]}")
  end

  get '/' do
    @people = Person.all
    haml :root
  end
  
  post '/' do
    @person = Person.find_by_name params['name']
    haml :find_person_by_name
  end

end
