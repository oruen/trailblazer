require 'bundler/setup'

Bundler.require

require 'sinatra/asset_pipeline'
require 'sinatra/ember'

class App < Sinatra::Base
  register Sinatra::Ember
  register Sinatra::AssetPipeline

  ember {
    templates '/templates.js', ['assets/javascripts/templates/*.handlebars'],
      :relative_to => 'assets/javascripts/templates'

    # optional; defaults to :path
    template_name_style :path
  }

  get '/' do
    haml :index
  end

  get '/search' do
    response.headers["Content-Type"] = "application/json"
    return "[]" if params[:q].empty?
    res = `grep "#{params[:q].inspect}" data/dump.json`.split("\n").map do |s|
      s.match(/\A[^{]({.*})\Z/)
      $1
    end.compact.join(",")
    "[#{res}]"
  end

  get '/object' do
    response.headers["Content-Type"] = "application/json"
    return "{}" if params[:q].empty?
    `grep '"id":#{params[:q]}' data/dump.json`.split("\n").map do |s|
      s.match(/\A[^{]({.*})\Z/)
      $1
    end.compact.first
  end
end

run App
