require_relative './decorator'

class TrimmerDecorator < Decorator
  if @nameable.correct_name.length > 10
    @nameable.correct_name.strip.slice(0,10)
end