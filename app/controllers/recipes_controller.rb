class RecipesController < ApplicationController
  before_filter :get_product
  # GET /recipes/1
  # GET /recipes/1.json
  def show
    # @title = t('view.recipes.show_title')
    @title = "Cómo fabricar #{@product}"
    @recipe = Recipe.includes(:components).find(params[:id])
    @components = @recipe.components
    @lowest_cost = @components.sum{ |component| component.lowest_cost[0] }
    @highest_cost = @components.sum{ |component| component.highest_cost[0] }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.json
  def new
    @title = t('view.recipes.new_title')
    @title = "Nueva receta para #{@product}"
    @recipe = @product.recipes.build

    render partial: 'recipes/new', content_type: 'text/html'
  end

  # GET /recipes/1/edit
  def edit
    @title = t('view.recipes.edit_title')
    @recipe = Recipe.find(params[:id])
    @title = "Editando #{@recipe}"

    render partial: 'recipes/edit', content_type: 'text/html'
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @title = t('view.recipes.new_title')
    @title = "Nueva receta para #{@product}"
    @recipe = @recipe = @product.recipes.new(params[:recipe])

    if @recipe.save
      js_redirect(to: product_recipe_path(@product, @recipe), message: t('view.recipes.correctly_created'))
    else
      render action: 'new', status: :unprocessable_entity
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.json
  def update
    @title = t('view.recipes.edit_title')
    @recipe = Recipe.find(params[:id])
    @title = "Editando #{@recipe}"

    if @recipe.update_attributes(params[:recipe])
      render partial: 'recipes/recipe', content_type: 'text/html'
    else
      render partial: 'edit', status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_product_recipe_url(@product, @recipe), alert: t('view.recipes.stale_object_error')
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      render nothing: true, content_type: 'text/html'
    end
  end

  private
    def get_product
      id = params[:product_id] || params[:custom_product_id] || params[:raw_product_id]
      @product = Product.find(id)
    end
end
