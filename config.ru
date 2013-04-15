require 'bundler/setup'

Bundler.require

require 'sinatra/asset_pipeline'

class App < Sinatra::Base
  register Sinatra::AssetPipeline

  get '/' do
    haml :index
  end

  get '/search' do
    response.headers["Content-Type"] = "application/json"
    res = `grep #{params[:q]} data/dump.json`.split("\n").map do |s|
      s.match(/\A[^{]({.*})\Z/)
      $1
    end.compact.join(",")
    "[#{res}]"
  end
end

run App
