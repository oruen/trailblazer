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
    res = normalize(`grep "#{params[:q].inspect}" data/dump.json`).join(",")
    "[#{res}]"
  end

  get '/object' do
    response.headers["Content-Type"] = "application/json"
    return "{}" if params[:q].empty?
    normalize(`grep -E '"id":"?#{params[:q]}' data/dump.json`).first
  end

  get '/related' do
    response.headers["Content-Type"] = "application/json"
    return "[]" if params[:q].empty?
    res = normalize(`grep #{params[:q]} data/dump.json | grep -v -E '"id":"?#{params[:q]}'`).join(",")
    "[#{res}]"
  end

  def normalize res
    res.split("\n").map do |s|
      s.match(/\A[^{]({.*})\Z/)
      $1
    end.compact
  end
end

run App
