
class Admin::StudentsController < ApplicationController
  def index
    @students = Student.all
  end
end
