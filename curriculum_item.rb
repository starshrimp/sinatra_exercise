class Curriculum_item
  attr_accessor :lesson_id, :lesson_name, :description
  def initialize(lesson_id, lesson_name, description)
    @lesson_id = lesson_id
    @lesson_name = lesson_name
    @description = description
  end
end
