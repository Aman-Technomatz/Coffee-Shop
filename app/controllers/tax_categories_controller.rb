class TaxCategoriesController < ApplicationController
  before_action :set_tax_category, only: %i[ show edit update destroy ]

  # GET /tax_categories or /tax_categories.json
  def index
    @tax_categories = TaxCategory.all
  end

  # GET /tax_categories/1 or /tax_categories/1.json
  def show
  end

  # GET /tax_categories/new
  def new
    @tax_category = TaxCategory.new
  end

  # GET /tax_categories/1/edit
  def edit
  end

  # POST /tax_categories or /tax_categories.json
  def create
    @tax_category = TaxCategory.new(tax_category_params)

    respond_to do |format|
      if @tax_category.save
        format.html { redirect_to tax_category_url(@tax_category), notice: "Tax category was successfully created." }
        format.json { render :show, status: :created, location: @tax_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tax_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tax_categories/1 or /tax_categories/1.json
  def update
    respond_to do |format|
      if @tax_category.update(tax_category_params)
        format.html { redirect_to tax_category_url(@tax_category), notice: "Tax category was successfully updated." }
        format.json { render :show, status: :ok, location: @tax_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tax_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tax_categories/1 or /tax_categories/1.json
  def destroy
    @tax_category.destroy

    respond_to do |format|
      format.html { redirect_to tax_categories_url, notice: "Tax category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_category
      @tax_category = TaxCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tax_category_params
      params.require(:tax_category).permit(:tax_rate)
    end
end
