require 'sinatra'

get '/' do
  #"Hello World 3"
  "Params are #{params}"
end

get '/test' do
  "Params are #{params}"
end

get '/formtest' do
  haml :testform
end

post '/formtest' do
  @text = params[:text]
  haml :testform
end
