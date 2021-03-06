class FillupsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @fillups = current_user.fillups.last(15)

    respond_to do |format|
      format.html
      format.json { render json: @fillups }
    end
  end

  # GET /fillups/1
  # GET /fillups/1.json
  def show
    @fillup = Fillup.find(params[:id])
    if @fillup.user_id == current_user.id
      respond_to do |format|
        format.html
        format.json { render json: @fillup }
      end
    else
      redirect_to fillups_path
      flash[:error] = 'That Fillup doesn\'t belong to you.'
    end
  end

  # GET /fillups/new
  # GET /fillups/new.json
  def new
    @fillup = Fillup.new

    respond_to do |format|
      format.html
      format.json { render json: @fillup }
    end
  end

  # GET /fillups/1/edit
  def edit
    @fillup = Fillup.find(params[:id])
    if @fillup.user_id != current_user.id
      redirect_to fillups_path
      flash[:error] = 'That Fillup doesn\'t belong to you.'
    end
  end

  # POST /fillups
  # POST /fillups.json
  def create
    @fillup = Fillup.new(params[:fillup])
    @fillup.user_id = current_user.id
    respond_to do |format|
      if @fillup.user_id == current_user.id && @fillup.save
        format.html { redirect_to @fillup, notice: 'Fillup was successfully created.' }
        format.json { render json: @fillup, status: :created, location: @fillup }
      else
        format.html { render action: "new" }
        format.json { render json: @fillup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fillups/1
  # PUT /fillups/1.json
  def update
    @fillup = Fillup.find(params[:id])

    respond_to do |format|
      if @fillup.user_id == current_user.id && @fillup.update_attributes(params[:fillup])
        format.html { redirect_to @fillup, notice: 'Fillup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", status: :unprocessable_entity }
        format.json { render json: @fillup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fillups/1
  # DELETE /fillups/1.json
  def destroy
    @fillup = Fillup.find(params[:id])
    if @fillup.user_id == current_user.id
      @fillup.destroy
      respond_to do |format|
        format.html { redirect_to fillups_url }
        format.json { head :no_content }
      end
    else
      redirect_to fillups_path
      flash[:error] = 'That Fillup doesn\'t belong to you.'
    end
  end
end
