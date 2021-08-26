class UsersController < ApplicationController

    def user_info
        @user = User.find( params[:id].to_s == external_id )
    end

    def user_payments
        parsing
        @payments = Payment.all
        @payments = @payments.select( |payment|{payment.user_id == @user.id } )
    end

    def user_transactions
        parsing
        @money_to_recive = []
        @money_recived =[]
        @transactions = @user.select(@user.transactions)
        @transactions.each do |transaction|
            if transaction.type == 1
                @money_recived << transaction
                @money_recived.sum
            else 
                @money_to_recive << transaction
                @money_to_recive.sum
            end
        end
    end 
end
