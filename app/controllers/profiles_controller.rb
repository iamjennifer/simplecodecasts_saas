class ProfilesController < ApplicationController
    def new
        #form where a user can fill out their own profile
       @user = User.find( params[:user_id] ) 
       #build a blank form object
       @profile = Profile.new
       
    end
    
    def create
        #getting this from url. getting our user id
        @user = User.find( params[:user_id] ) 
        #save the form 
        @profile = @user.build_profile(profile_params)
        if @profile.save
            #redirect to user show page
            flash[:success] = "Profile Updated"
            redirect_to user_path( params[:user_id] )
        else
            render action: :new
        end
    end
    
    def edit
       @user = User.find( params[:user_id] ) 
       @profile = @user.profile
    end
    
    #whenever you are trying thing from a public form into your db, you need to white list them
    private
    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
    end
    
end