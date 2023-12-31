require 'sinatra'
require 'csv'
require 'logger'
require_relative './curriculum_item.rb'

logger = Logger.new(STDOUT)

before do
  @curriculum_items = []
end

def parse_csv
  CSV.foreach('curriculum.csv', headers: true) do |row|
    if row.size != 3 
      puts "[ERROR] Something's wrong with this curriculum line: #{row}!"
      return
    end
    lesson_id = row[0]
    lesson_name = row[1]
    description = row[2]
    curriculum_item = Curriculum_item.new(lesson_id, lesson_name, description)
    @curriculum_items.push(curriculum_item)
  end
end


get '/curriculum' do
  parse_csv
  @current_time = Time.now
  erb :curriculum
end

get '/curriculum/:lesson' do
  parse_csv
  lesson_id = params['lesson']
  p "Lesson: #{lesson_id}"
  # Find the curriculum item with the matching lesson_id
  curriculum_item = nil
  @curriculum_items.each do |item|
    if item.lesson_id == lesson_id
      p "Found curriculum item: #{item}"
      curriculum_item = item
      break  # Exit the loop as soon as a match is found
    end
  end
  if curriculum_item
    erb :curriculum_subpage, locals: { curriculum_item: curriculum_item }
  else
    "Curriculum item not found"
  end
end
