require File.dirname(__FILE__) + '/init'

# Shows an octopus status page.
#
get '/' do
  @resources = NetResource.all(:limit => 50, :order => [:next_update.asc])
  @resource_count = NetResource.count
  @subscription_count = Subscription.count
  erb :index
end

# Displays a form to create a new resource.
#
get '/new' do
  @resource = NetResource.new
  @subscription = Subscription.new
  erb :new
end


# Displays an edit page for a resource.
#
get '/edit/:id' do
  @resource = NetResource.get(params[:id])
  erb :edit
end


# Creates a resource with an associated subscription.  If the resource already
# exists, the subscription will be appended to it instead of creating a new one.
#
post '/create' do
  @resource = NetResource.first(:url => params[:net_resource][:url])
  @resource = NetResource.new(params[:net_resource]) if @resource.nil?
  @subscription = Subscription.new(params[:subscription])
  @resource.subscriptions << @subscription
  if @resource.save
    flash[:notice] = "Net resource created."
    redirect '/'
  else
    erb :new
  end
end


# Updates a resource.
#
put '/update/:id' do
  @resource = NetResource.get(params[:id])
  if @resource.update(params[:net_resource])
    flash[:notice] = "Net resource updated."
    redirect '/'
  else
    erb :edit
  end
end


# Figures out whether it's getting a new resource to watch or is editing
# an existing resource and redirects the user appropriately.
#
post '/new_or_edit' do
  resource = NetResource.first(:url => params[:net_resource][:url])
  if resource.nil?
    redirect '/new'
  else
    redirect "/edit/#{resource.id}"
  end
end

# Starts the octopus grabbing thread. The thread will be reabsorbed into the
# main Sinatra/thin thread once the periodic timer is added.
#
Thread.new do
  until EM.reactor_running?
    sleep 1
  end
  Grabbers::GenericHttp.new
end

