require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require 'sinatra/contrib'
require 'pg'
require_relative './models/Car.rb'
require_relative './controllers/cars_controller.rb'

use Rack::Reloader
use Rack::MethodOverride

run App
