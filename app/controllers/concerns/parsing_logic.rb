
module ParsingLogic
  extend ActiveSupport::Concern

    def parsing
    response = Faraday.get('https://increase-transactions.herokuapp.com/file.txt') do |req|
        req.headers['Authorization'] = 'Bearer 1234567890qwertyuiopasdfghjklzxcvbnm'
      end
      ​
      lines = response.body.split(/\n/)
      ​
      counter = 0
      results = []
      lines.each do |line|
        results[counter] ||= []
        results[counter] << line
        counter += 1 if line[0] == "4"
      end
      ​
      results.each do |result|
        user = User.find_or_create_by(external_id: result.last[12..34])
        payment_args = {
          user: user,
          external_id: result[0][1..33],
          tipe_of_currency: result[0][36..39],
          total_amount: result[0][39..48],
          total_discount: result[0][48..51],
          total_with_discount: result[0][51..53]
        }
        payment = Payment.create(payment_args)
        transaction_lines = result.select { |line| line[0] == "2" }
        transaction_lines.each do |transaction_line|
          transaction_args = {
            user: user,
            payment: payment,
            id_transaction: transaction_line[123..123],
            amount: transaction_line[123..123],
            type: transaction_line[123..123]
          }
          Transaction.create(transaction_args)
        end
        discount_lines = result.select { |line| line[0] == "2" }
        discount_lines.each do |discount_line|
          discount_args = {
            user: user,
            payment: payment,
            id_discount: discount_line[123..123],
            amount: discount_line[123..123],
            type: discount_line[123..123]
          }
          Discount.create(discount_args)
        end
      end
    end
end