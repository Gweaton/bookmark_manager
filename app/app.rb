ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/models/link.rb'
require 'data_mapper'
require './app/models/data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :links
  end

  get '/links/new' do
    erb :new
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tag = Tag.create(name: params[:tag])
    link.tags << tag
    link.save
    redirect('/links')
  end

  get '/tags/:name' do
    puts params[:name]
    tag = Tag.first(name: params[:name])#PROBLEM
    @links = tag ? tag.links : []
    puts tag
    puts 'HERE!!!!!!!!!!!!!!!!'
    puts @links
    erb :'links/index'
  end


  run! if app_file == $0
end
