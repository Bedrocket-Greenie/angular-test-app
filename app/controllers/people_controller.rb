class PeopleController < ApplicationController
  respond_to :json

  def index
    respond_with Person.all
  end

  def show
    respond_with Person.find(params[:id])
  end

  def create
    respond_with Person.create(params[:person])
  end

  def update
    respond_with Person.update(params[:id], params[:person])
  end

  def destroy
    respond_with Person.destroy(params[:id])
  end
end
