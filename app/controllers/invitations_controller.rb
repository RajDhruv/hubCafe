class InvitationsController < ApplicationController

  def new_request_log
    cafe_id=params[:cafe_id]
    requestor_id=params[:requestor_id]
    @cafe=Cafe.find_by_id(cafe_id)
    invitation=Invitation.new
    invitation.cafe_id=cafe_id
    invitation.requestor_id=requestor_id
    invitation.approver_id=@cafe.admin_id
    invitation.created_at=Time.now
    invitation.updated_at=Time.now
    if invitation.save
      @msg="Invitation to join #{@cafe.name} Cafe has been successfully sent."
      @success=true
    else
      @msg="Invitation to join #{@cafe.name} Cafe could not be sent due to some issues."
      @success=false
    end
    render :partial=>"invitations/invitation_redirection.js.erb",:locals=>{:from=>"new_request_log"}
  end


  def view_requests
    @invitations=Invitation.where('approver_id=? and lock_version<>-1',session[:current_user]["id"])
    render :partial=>"invitations/invitation_redirection.js.erb",:locals=>{:from=>"view_requests"}
  end

  def take_action
    type=params[:action_type]
    @invitation=Invitation.find_by_id(params[:for_id])
    if type=="accept"
      @membership=CafeUser.new
      @membership.cafe_id=@invitation.cafe_id
      @membership.user_id=@invitation.requestor_id
      @membership.created_at=Time.now
      @membership.updated_at=Time.now
      @membership.from_invitation=@invitation.id
      if @membership.save
          replacement_text='<span style="color:orange;">Approved</span>'
          @success=true
      else
        @msg="Some Issue Occured. Please try again later."
        @success=false
      end
    else
      update_query="Update invitations set lock_version=-1 where id=#{params[:for_id]}"
      rs=ActiveRecord::Base.connection.execute(update_query)
        if rs.nil?
          replacement_text='<span style="color:red;">Ignored</span>'
          @success=true
        else
          @msg="Some Issue Occured. Please try again later."
          @success=false
        end
    end
    render :partial=>"invitations/invitation_redirection.js.erb",:locals=>{:from=>"take_action",:replacement_text=>replacement_text}
  end
end
