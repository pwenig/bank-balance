desc "Used to generate the test data.  You do NOT need to run this task if you are just doing the exercise."
task :generate do
  require 'faker'
  require 'active_support/all'
  require 'money'
  require 'csv'

  checking_transactions = []
  card_transactions = []
  check_number = 1024

  range_of_dates = "2014-01-01".to_date.."2014-06-30".to_date

  range_of_dates.each.with_index(1024) do |date|

    if date == date.end_of_month
      checking_transactions << {
        description: "Deposit #{%w(ATM Bank Online).sample}",
        credit: Money.new(Time.days_in_month(date.month, date.year) * 100 * 100),
        date: date
      }
    end

    if date == date.end_of_week
      [60, 120, 74, 82].each do |amount|
        checking_transactions << {
          description: "Check ##{check_number += 1}",
          debit: Money.new(amount * 100),
          date: date
        }
      end
    end

    rand(3).times do
      card_transactions << {
        description: Faker::Commerce.product_name,
        amount: Money.new(Faker::Commerce.price * 100),
        date: date
      }
    end

  end

  %w(2014-02-14 2014-03-21 2014-05-04 2014-06-23).each do |date_string|
    amount = rand(100000)
    date = date_string.to_date

    card_transactions << {
      description: "Payment Thank You",
      amount: Money.new(amount * -1),
      date: date
    }

    checking_transactions << {
      description: "Payment CC",
      debit: Money.new(amount),
      date: date
    }
  end

  months = {}

  card_transactions.group_by { |transaction| transaction[:date].strftime("%B") }.each do |month, transactions|
    sum = Money.new(0)
    CSV.open("data/statement-credit-card-#{month.downcase}-2014.csv", "w") do |csv|
      csv << %w(Description Amount Date)
      transactions.each do |transaction|
        sum = sum + transaction[:amount] unless transaction[:description] == "Payment Thank You"
        csv << [
          transaction[:date],
          transaction[:description],
          transaction[:amount].format,
        ]
      end
    end
    months[month] = sum * -1
  end

  checking_transactions.group_by { |transaction| transaction[:date].strftime("%B") }.each do |month, transactions|
    expenses = Money.new(0)
    income = Money.new(0)
    CSV.open("data/statement-checking-#{month.downcase}-2014.csv", "w") do |csv|
      csv << %w(Date Description Credit Debit)
      transactions.each do |transaction|
        expenses += transaction[:debit] if transaction[:debit] && transaction[:description] != "Payment CC"
        income += transaction[:credit] || Money.new(0)
        csv << [
          transaction[:date],
          transaction[:description],
          transaction[:credit].try(:format),
          transaction[:debit].try(:format),
        ]
      end
    end
    months[month] += income - expenses
  end

  puts "Copy this to the readme:"
  puts
  puts "Year | Month         | Balance"
  puts "---- | ------------- | --------"

  months.each do |month, value|
    puts "2014 | #{month.ljust(13, " ")} | #{value.format.ljust(0, " ")}"
  end
  puts
end