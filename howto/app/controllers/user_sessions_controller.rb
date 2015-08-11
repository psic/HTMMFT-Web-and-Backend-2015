class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end

  def create
 

	  Rails.logger.level = 0 
    @user_session = UserSession.new(params[:user_session])
   # logger.debug "User Session #{@user_session.inspect}"


    if @user_session.save
      flash[:notice] = "Connecte."
	logger.debug "User Session #{@user_session.inspect}"
      # redirect_to root_url
     redirect_to "/mon_equipe"
    else
	logger.debug "{u.errors.full_messages.inspect}"    
	logger.debug "{@user_session.errors.full_messages.inspect}"
	#    render :action => 'new'
	redirect_to "/"
    end
  end
  def destroy
  #  @user_session = UserSession.find(params[:id])
 #  @user_session.destroy
     current_user_session.destroy
    flash[:notice] = "Deconnecte."
    redirect_to "/"
    #redirect_to index_user_url
  end
end
