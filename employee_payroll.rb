class Employee
	attr_reader :name, :email
	def initialize name, email
		@name=name
		@email=email
	end
end

class HourlyEmployee < Employee
    def initialize(name, email, hourly_rate, hours_worked)
        @name = name
        @email = email
        @hourly_rate = hourly_rate
        @hours_worked = hours_worked
    end

    def calculate_salary
    	@hourly_rate*@hours_worked
      #returns the hours worked * hourly_rate
    end
end


class SalariedEmployee < Employee
    def initialize(name, email, year_rate)
        @name = name
        @email = email
        @year_rate = year_rate
    end

    def calculate_salary
    	(@year_rate/365)*7
      #returns the hours worked * hourly_rate
    end
end


class MultiPaymentEmployee < Employee
    def initialize(name, email, year_rate,hourly_rate, hours_worked)
        @name = name
        @email = email
        @year_rate = year_rate
        @hourly_rate = hourly_rate
        @hours_worked = hours_worked
    end

    def calculate_salary
    	mounth=(@year_rate/(365))*7
    	overTyme=(@hours_worked.to_i>50) ? @hours_worked-50 : 0
    	mounth+(@hourly_rate*overTyme)
      #returns the hours worked * hourly_rate
    end
end

class Payroll
    def initialize(employees,tax)
        @employees = employees
    	@tax = tax
    end

    def notify_employee(employee)
          #email them
          puts "send email to #{employee.email}"
  	end

  	def pay_employees
  		@employees.each do |employee| 
  		puts "#{employee.name} => #{employee.calculate_salary-((@tax*employee.calculate_salary)/100)}"
  		notify_employee(employee)
  		end
  	end
end

josh = HourlyEmployee.new('Josh', 'nachoemail@example.com', 35, 50)
nizar = SalariedEmployee.new('Nizar', 'starcraftrulez@gmail.com', 1000000)
ted = MultiPaymentEmployee.new('Ted', 'fortranr0x@gmail.com', 60000, 275, 55)

employees = [josh, nizar, ted, HourlyEmployee.new('Goe','goe@goe.es',15,50)]
payroll = Payroll.new(employees,18)
payroll.pay_employees