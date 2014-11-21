class ComponentsController < ApplicationController
  before_filter :get_product_and_recipe

  # GET /components/new
  # GET /components/new.json
  def new
    @title = t('view.components.new_title')
    @component = @recipe.components.build

    render partial: 'components/new', content_type: 'text/html'
  end

  # GET /components/1/edit
  def edit
    @title = t('view.components.edit_title')
    @component = Component.find(params[:id])

    render partial: 'components/edit', content_type: 'text/html'
  end

  # POST /components
  # POST /components.json
  def create
    @title = t('view.components.new_title')
    @component = @recipe.components.new(params[:component])

    if @component.save
      render partial: 'components/component', content_type: 'text/html', locals: { component: @component }
    else
      render partial: 'components/new', status: :unprocessable_entity
    end
  end

  # PUT /components/1
  # PUT /components/1.json
  def update
    @title = t('view.components.edit_title')
    @component = Component.find(params[:id])

    if @component.update_attributes(params[:component])
      render partial: 'components/component', content_type: 'text/html', locals: { component: @component }
    else
      render partial: 'components/edit', status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_product_recipe_component_url(@product, @recipe, @component), alert: t('view.components.stale_object_error')
  end

  # DELETE /components/1
  # DELETE /components/1.json
  def destroy
    @component = Component.find(params[:id])
    if @component.destroy
      render nothing: true, content_type: 'text/html'
    end
  end

  private
    def get_product_and_recipe
      @product = Product.find(params[:product_id])
      @recipe  = Recipe.find(params[:recipe_id])
    end
end
