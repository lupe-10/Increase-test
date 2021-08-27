
module Api
    module V1
        class UsersController < ApplicationController

            def user_info
                parsing
                @user = User.find( params[:id].to_s == external_id )
                id = @user.id
                response = Faraday.get "https://increase-transactions.herokuapp.com/clients/#{id}"
                render json: response
            end

            def user_payments
                parsing
                @payments = Payment.all
                @payments = @payments.select( | payment |{payment.user_id == @user.id } )
                render json: @payments 
            end

            def user_transactions
                parsing
                @money_to_recive = []
                @money_recived =[]
                @transactions = @user.select( |user|{ user.transactions } )
                @transactions.each do |transaction|
                    if transaction.type == 1
                        @money_recived << transaction
                        @money_recived.sum
                    else 
                        @money_to_recive << transaction
                        @money_to_recive.sum
                    end
                end
                render json: @money_to_recive
                render json: @money_recived
            end 
        end
    end 
end 
