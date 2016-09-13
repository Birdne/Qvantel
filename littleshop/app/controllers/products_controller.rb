class ProductsController < ApplicationController
  
  # Shows the list of all products or the search results 
  def index
    @products = Product.all
	# TASK-4
	if params['start_on'] != "" && params['end_on'] != ""
      @products = @products.where(price: params['start_on']..params['end_on'])
	end
	# TASK-5
    if params['search'] != ""
      @products = @products.where("product_name LIKE ?", "#{params['search']}%")
	end
	# TASK-3
	if params['sorting_key'] != ""
      @products = @products.order(params['sorting_key'])
    end
	@products = @products.first(100)
    
    @order_item = current_order.order_items.new
  end

  # Shows a single products information on screen
  def show
    @product = Product.find(params[:id])
  end
  
  # TASK-1 the following functions are related to adding/removinh/editing products
  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    ## Checking if the product can be saved, if not there were errors with the values 
	# given and the product creation screen is shown again to the user with the errors 
	# messages shown
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  # Little method for the product's valid parameters
  private
    def product_params
      params.require(:product).permit(:product_name, :price, :amount_in_stock)
    end
end
