class MainController < ApplicationController
	respond_to :json

	def c
		session[:crypto] = session[:crypto] ? session[:crypto] : Crypto.new		
	end

	def index
		@primes = c.get_primes_until 1000
	end

	def get_e_possibilities
		respond_to do |format|
      format.json { render :json => c.get_e_possibilities(params[:p].to_i, params[:q].to_i).to_json }
    end
	end

	def get_d
		respond_to do |format|
      format.json { render :json => c.get_d(params[:e].to_i).to_json }
    end
	end

	def encrypt		
		respond_to do |format|
      format.json { render :json => r = c.encrypt(params[:input]).to_json }
    end
	end

	def decrypt
		respond_to do |format|
      format.json { render :json => c.decrypt(params[:encrypted]).to_json }
    end
	end
end
