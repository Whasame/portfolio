require 'mailgun'
require 'bundler'
require 'twilio-ruby' 
Bundler.require

require './models/model.rb'

class MyApp < Sinatra::Base
	
	get '/' do
		erb :index
	end
	
	post '/text' do
		@body = "Sent From: #{params[:returnName]} (#{params[:returnNum]})


#{params[:body]}"

		account_sid = "ACe30ea6a63d05386cb6cac9a48615cd8e" 
		auth_token = "7ae7a566fd115e1e450986cb36ce315b" 

		client = Twilio::REST::Client.new account_sid, auth_token 
 
		from = "+13477457924"
		
		friends = { "+15417052920" => "User" } 
		friends.each do |key, value|
		client.account.messages.create( 
			:from => from, 
			:to => key, 
			:body => "#{@body}" 
		) 
			puts "Sent message from #{params[:returnName]}"
			redirect '/'
		end 
	end
	
end