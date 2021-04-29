class InvitesController < ApplicationController
  
  def create
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.sender_id = current_user.id # set the sender to the current user
    if @invite.save

      #if the user already exists
      if @invite.recipient != nil 
        #send a notification email
        InviteMailer.existing_user_invite(@invite).deliver 

        #Add the user to the user group
        @invite.recipient.account.push(@invite.account)
      else
        InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
      end
      
    else
      flash[:notice] = "There was an error"
      redirect_to 
    end
 end

 private

  def invite_params
    params.require(:invite).permit(:email, :sender_id, :recipient_id, :token)
  end
end
