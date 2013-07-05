class MonthlyMovementsController < ApplicationController
  
  def index
    @title = t('view.monthly_movements.index_title')
    @monthly_movements = MonthlyMovement.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @monthly_movements }
    end
  end

  def show
    @monthly_movement = MonthlyMovement.find(params[:id])
    @title = t('view.monthly_movements.show_title', month: @monthly_movement.month, year: @monthly_movement.year)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @monthly_movement }
    end
  end

  def new
    @title = t('view.monthly_movements.new_title')
    @monthly_movement = @current_user.monthly_movements.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @monthly_movement }
    end
  end

  def edit
    @monthly_movement = MonthlyMovement.find(params[:id])
    @title = t('view.monthly_movements.edit_title', month: @monthly_movement.month)
  end

  def create
    @title = t('view.monthly_movements.new_title')
    @monthly_movement = @current_user.monthly_movements.build(params[:monthly_movement])

    respond_to do |format|
      if @monthly_movement.save
        format.html { redirect_to @monthly_movement, notice: t('view.monthly_movements.correctly_created') }
        format.json { render json: @monthly_movement, status: :created, location: @monthly_movement }
      else
        format.html { render action: 'new' }
        format.json { render json: @monthly_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @title = t('view.monthly_movements.edit_title')
    @monthly_movement = MonthlyMovement.find(params[:id])

    respond_to do |format|
      if @monthly_movement.update_attributes(params[:monthly_movement])
        format.html { redirect_to @monthly_movement, notice: t('view.monthly_movements.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @monthly_movement.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_monthly_movement_url(@monthly_movement), alert: t('view.monthly_movements.stale_object_error')
  end

  def set_as_send
    @monthly_movement = MonthlyMovement.find(params[:id])
    @monthly_movement.set_as_send
    redirect_to :back
  end

  def set_as_finalized
    @monthly_movement = MonthlyMovement.find(params[:id])
    @monthly_movement.set_as_finalized
    redirect_to :back
  end
end
