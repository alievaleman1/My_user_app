require 'sinatra'
require 'json'
require_relative 'my_user_model'

set :port,8080
set :bind,'0.0.0.0'
set :views, './views'
enable :sessions

def safe_user(user)
    {
      "id" => user.id,
      "firstname" => user.firstname,
      "lastname" => user.lastname,
      "age" => user.age,
      "email" => user.email
    }
end

# safe_user(user).to_json

# def require_login 

#   end
# metod yarat egər sessionda user_id yoxdursa requesti 401 Unauthorized cavabı ilə dayanrim 

get '/users' do
    content_type :json
    users = User.all.map {|u| safe_user(u)}
    return users.to_json
end
#get butun userlerin qaytarir useral butun user obyektlerini qaytarir map her 
#obyekti passwordsuz hasha cevirir hash/array json metnine cevirir 


post '/users' do
    content_type :json
#     p params.to_h
#     if session[:user_id]
#         User.create(params)

#         status 204
#         return params.to_h
#     end
#     return 401
# end
     user = User.create(params)
     status 201
     return {
      "id" => user.id,
      "firstname" => user.firstname,
      "lastname" => user.lastname,
      "age" => user.age,
      "email" => user.email
     }.to_json
end

post '/sign_in' do
    content_type :json
    user=User.all.find do |u|
        u.email==params['email'] && u.password==params['password']
    end

    if user
        session[:user_id] = user.id

        status 200
        return { message: 'Login successful', user_id: session[:user_id] }.to_json
    end

  status 401
  { error: 'User not found' }.to_json
end
put '/users' do
    content_type :json
    user_id=session[:user_id]
    if !user_id
        status 401
            return { message:'unauthorized' }.to_json
    end
    # user=User.find(user_id)
    user=User.update(user_id,'password',params['password'])
    safe_user(user).to_hash.to_json
end
#     user = User.all.find do |u|
#     u.password == params['password']
#   end
#     if user
#         session[:user_id] = user.id
#         status 200
#             return { message: 'Login successful', user_id: session[:user_id] }.to_json
#     else 
#         status 401
#             return { message: 'Alinmadi ' }.to_json
#     end
# end

delete '/sign_out' do
    content_type :json
    user_id = session[:user_id]
    if !user_id
        status 401
            return { message:'unauthorized' }.to_json
    end
    session.clear
    status 204
    body ''
end

# delete '/users/:id' do
#     content_type :json
#     user_id=session[:user_id]
#     if !user_id
#         status 401
#             return { message:'unauthorized' }.to_json
#     end
#     user = User.find_by(id: params[:id])
#     if !user
#          status 404
#         return { message: 'User not found' }.to_json
#   end
    
#     if  user.id!=user_id
#          status 403
#          return { message: 'Forbidden' }.to_json
#   end
#     # User.destroy(i)
#     # status 204
#     # return {"message":"User deleted"}.to_json
#      User.destroy(user_id)
#      session.clear
#      status 204
#      body ''
# end 

delete '/users' do
  content_type :json
  user_id = session[:user_id]
  if !user_id
    status 401
    return { message: 'Unauthorized' }.to_json
  end
  User.destroy(user_id)
  session.clear
  status 204
end
get '/' do
    content_type :html
    send_file File.join(settings.views, 'index.html')
  end