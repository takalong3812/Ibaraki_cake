class Public::UsersController < ApplicationController
    
    def show
        @user= current_user
    end
    
    def edit
        @user = current_user
    end
    
     def update
       @user = current_user
       if @user.update(user_params)
       flash[:success] = "登録情報を編集しました。"
       redirect_to public_user_path(current_user)
       else
       flash[:alert] = "もう一度入力してください。"
       render :user_edit
       end
      
     end
     
     def unsubscribe
        @user = User.find(params[:id])
     end
     
     def withdrawal
        @user = current_user
        @user.update(is_deleted: true)
        reset_session
        flash[:notice] = "退会処理を実行いたしました"
        redirect_to root_path
    
     end
     
     private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
    
end
