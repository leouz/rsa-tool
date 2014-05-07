class EccController < ApplicationController
	respond_to :json

	def index
    @algorithm = "ECC"		
	end

	def eliptic_groups
    c = Ecc::ElipticGroups.new params[:p].to_f, params[:a].to_f, params[:b].to_f
		respond_to do |format|
      format.json { render :json => c.result.to_json }
    end
	end

  def sum        
    a = params[:a].to_f if params[:a]
    c = Ecc::SumDiff.new params[:p].to_f, a, params[:x1].to_f, params[:y1].to_f, params[:x2].to_f, params[:y2].to_f
    
    respond_to do |format|
      format.json { render :json => c.get_sum.to_json }
    end
  end

  def diff
    a = params[:a].to_f if params[:a]
    c = Ecc::SumDiff.new params[:p].to_f, a, params[:x1].to_f, params[:y1].to_f, params[:x2].to_f, params[:y2].to_f
    
    respond_to do |format|
      format.json { render :json => c.get_diff.to_json }
    end
  end

  def product    
    c = Ecc::Product.new params[:x1].to_f, params[:y1].to_f, params[:p].to_f, params[:a].to_f, params[:n].to_f
    
    respond_to do |format|
      format.json { render :json => c.result.to_json }
    end
  end
end
