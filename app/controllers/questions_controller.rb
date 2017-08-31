class QuestionsController < ApplicationController
  # GET /questions
  def index
	  question = Question.search(params[:query])
	  @questions = question.to_json(include: { answers: { only: :body } } )
	  json_response(@questions)
  end

  # GET /questions/:id
  def show
  	question = Question.find(params[:id])
  	@question = question.to_json(include: { answers: { only: :body } } )
  	json_response(@question)
  end
end
