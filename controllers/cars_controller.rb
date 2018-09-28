class App < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  # Setting the root as the parent directory of the current dircetory.
  set :root, File.join(File.dirname(__FILE__), '..')

  # Sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }



  # INDEX
    get '/cars' do
      @make = "Index Page"
      @cars = Car.all

      erb :'cars/index'
    end

    # NEW
    get '/cars/new' do
      erb :'cars/new'
    end

    # SHOW
    get '/cars/:id' do
      id = params[:id].to_i
      @car = Car.find id

      erb :'cars/show'
    end

    # CREATE
    post '/cars' do

      car = Car.new

      car.make = params[:make]
      car.model = params[:model]
      car.engine = params[:engine]

      car.save

      redirect '/cars'


    end

    # UPDATE
    put '/cars/:id' do
      id = params[:id].to_i

      car = Car.find id

      car.make = params[:make]
      car.model = params[:model]
      car.engine = params[:engine]

      car.save

      redirect '/cars'

    end

    # DELETE
    delete '/cars/:id' do
      id = params[:id].to_i
      Car.destroy id
      redirect '/cars'
    end

    # EDIT
    get '/cars/:id/edit' do
      id = params[:id].to_i
      @car = Car.find id
      erb :'cars/edit'
    end



    # /
    post '/cars' do
      "CREATE car"
    end

  end
