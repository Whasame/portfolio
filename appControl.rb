require 'bundler'
Bundler.require

require './models/model.rb'

class MyApp < Sinatra::Base
	
	get '/' do
		erb :index
	end
	
	get '/questions' do
		@qnum = 1
		@questions = "Are you under 18 years of age? (Please answer truthfuly)"
		erb :questions
		
	end
	
	post '/questions' do
		curr_question = params[:question]
		@answer = params[:ans]
		
		if @answer == "Yes"
			@ans_value=0
		elsif @answer == "No"
			@ans_value=1
		end

		map={
			"Are you under 18 years of age? (Please answer truthfuly)" => {:next_q => ["Are you being forced to do anything?", "Are you trading sex acts for anything of monetary value?"], :remove => []},
			
			"Are you being forced to do anything?" => {:next_q => ["Are you performing any sex acts?", "Do you have a boyfriend or girlfriend?"], :remove => []},
			
			"Are you performing any sex acts?" => {:next_q =>["Victim", "NotVictim"], :remove => []},
			
			"Do you have a boyfriend or girlfriend?" => {:next_q => ["Does he/she engage in sexual acts with you?", "Are you participating in any sex acts?"], :remove => []},
			
			"Are you trading sex acts for anything of monetary value?" => {:next_q => ["Victim", "Are you being forced to perform any sex acts?"], :remove => []},
			
			"Are you participating in any sex acts?" => {:next_q => ["Victim", "NotVictim"], :remove => []},
			
			"Are you being forced to perform any sex acts?" => {:next_q => ["Victim", "NotVictim"]},
			
			"Does he/she engage in sexual acts with you?" => {:next_q => ["Victim", "NotVictim"]}
			}
		
		@questions = map[curr_question][:next_q][@ans_value]

		if @questions.include? '?'
			erb :questions
		elsif @questions=="Victim"
			erb :victim
		elsif @questions=="NotVictim"
			erb :notVictim
		else
			next
			#ss
		end

	end
end