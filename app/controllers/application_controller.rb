class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  layout 'main' 
  
  

  def register

  	@email = params[:email]
  	@password = params[:password]
  	@password_confirmation = params[:password_confirmation]
   
   if @password == @password_confirmation    
   user = User.create_with_password(@email, @password)
      if user 
          session[:signed_in] = true
          redirect_to '/home'
         else
	  redirect_to '/sign_in.html'
    end
    end
    end

   def home
    
    unless session[:signed_in] == true
           redirect_to '/sign_in.html'
      end

   end

  def logout
  	  session[:signed_in] = false
  	  redirect_to '/sign_in.html'
  		
  	end	

 def login
    @email = params[:email]
 	  @password = params[:password]

 	  user = User.where(email: @email).first

     if user
 	  valid = user.verify_password(@password)
  
      if valid
	   session[:signed_in] = true
 	   session[:email] = params[:email]
 	   redirect_to '/home'

     else
	   redirect_to '/sign_in.html'

     end

    else 	
	  redirect_to '/sign_in.html'
    end



  	end
 
end
