require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @receiver.valid?
    @sender.valid?
  end

  def execute_transaction
    if @status == "pending" && valid?
      sender.balance -= amount
      receiver.balance += amount
      @status = "complete"
    end
    if !@sender.valid?
      binding.pry
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete" && valid?
      sender.balance += amount
      receiver.balance -= amount
      @status = "reversed"
    end
  end
end
