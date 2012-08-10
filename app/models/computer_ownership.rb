

class ComputerOwnership < ActiveRecord::Base
  attr_accessible :enddate, :startdate, :student_id, :computer_id, :student_idnum, :computer_tag
  
  belongs_to :computer
  belongs_to :student

  after_initialize do
  	self.startdate = Date.today
  end
  
  def current?
    return true if self.enddate.nil?
    return false
  end

  def student_idnum=(studentid)
  	students = like_query Student, :studentid, studentid
  	if students.empty? then
  		self.student_id = nil
  	else
  		self.student_id = 0 if students.length > 1
  		self.student_id = students.first.id if students.length == 1
  	end
  end

  def computer_tag=(tag)
  	computers = like_query Computer, :idtag, tag
  	if computers.empty? then
  		self.computer_id = nil
  	else
  		self.computer_id = 0 if computers.length > 1
  		self.computer_id = computers.first.id if computers.length == 1
  	end
  end

  def student_idnum
  	self.student.studentid if self.student 
  end

  def computer_tag
  	self.computer.idtag if self.computer
  end

	class StudentIdValidator < ActiveModel::Validator
		def validate(record)
			if record.student_id.nil? then
				record.errors[:student_idnum] = "No student with that ID!"
			else
				if record.student_id == 0 then
					record.errors[:student_idnum] = "Multiple students match that ID!"
				else
					record.errors[:student_idnum] = "A student can only have one computer at a time!" if record.student.current_computer
				end
			end
		end
	end

	class ComputerIdValidator < ActiveModel::Validator
		def validate(record)
			if record.computer_id.nil? then
				record.errors[:computer_tag] = "No computer with that ID!"
			else
				if record.computer_id == 0 then
					record.errors[:computer_tag] = "Multiple computers match that ID!"
				end
			end
		end
	end

	class ComputerSingleOwnerValidator < ActiveModel::Validator
		def validate(record)
			unless record.computer.nil? then
				record.errors[:computer_tag] = "A computer may only be assigned to one student!" unless record.computer.get_current_student.nil?
			end
		end
	end

	validates_with StudentIdValidator, :on => :create
	validates_with ComputerIdValidator, :on => :create
	validates_with ComputerSingleOwnerValidator, :on => :create

	def query_helper name, value, query_string, query_array
		if !value.nil? then
		  if !value.empty? then
		    query_string += " OR " unless query_string.empty?
		    query_string += "#{name} LIKE ?"
		    query_array.push("%#{value}%")
		  end
		end
		query_string
	end

	def like_query on, field, value
		query = ""
		query_array = []
		query = query_helper field, value, query, query_array

		on.where(query, *query_array)
	end
end


