require 'pry'
class Transfer
  attr_reader :status, :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender =   sender
    @receiver = receiver
    @status =   'pending'
    @amount =   amount
  end

  def both_valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    unless @status == 'complete'
      if sender.balance >= @amount
        sender.balance -= @amount
        receiver.balance += @amount
        @status = 'complete'
      else
        @status = 'rejected'
        'Transaction rejected. Please check your account balance.'
      end
    end
  end

  def reverse_transfer
    if @status == 'complete'
      sender.balance += @amount
      receiver.balance -= @amount
      @status = 'reversed'
    end
  end
end
