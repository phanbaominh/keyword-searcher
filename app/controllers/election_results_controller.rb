# frozen_string_literal: true

class ElectionResultsController < ApplicationController
  def search
    render json: ElectionResult.of(params).to_json(include: %i[election party country])
  end

  def index
    logger.info params
  end

  # private

  # def search_params
  #   params.permit(election: { name: {} }, country: { name: {} }, party: { name: {} })
  # end
end
