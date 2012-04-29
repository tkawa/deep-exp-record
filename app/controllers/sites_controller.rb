class SitesController < ApplicationController
  before_filter :authorize, :only => [:new, :edit, :create, :update, :destroy]
  # GET /users/:user_id/sites
  # GET /users/:user_id/sites.json
  def index
    @user = User.find(params[:user_id])
    @sites = @user.sites

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /users/:user_id/sites/1
  # GET /users/:user_id/sites/1.json
  def show
    @user = User.find(params[:user_id])
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end

  # GET /users/:user_id/sites/new
  # GET /users/:user_id/sites/new.json
  def new
    @user = User.find(params[:user_id])
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /users/:user_id/sites/1/edit
  def edit
    @user = User.find(params[:user_id])
    @site = Site.find(params[:id])
  end

  # POST /users/:user_id/sites
  # POST /users/:user_id/sites.json
  def create
    @user = User.find(params[:user_id])
    @site = Site.new(params[:site])
    @site.user_id = params[:user_id] # TODO: can create only me

    respond_to do |format|
      if @site.save
        format.html { redirect_to user_sites_url(@site.user), notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: user_sites_url(@site.user) }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/:user_id/sites/1
  # PUT /users/:user_id/sites/1.json
  def update
    @user = User.find(params[:user_id])
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:user_id/sites/1
  # DELETE /users/:user_id/sites/1.json
  def destroy
    @user = User.find(params[:user_id])
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private
  def authorize
    @user = User.find(params[:user_id])
    unless @user == current_user
      respond_to do |format|
        format.html { redirect_to :back, alert: 'Unauthorized operation.' }
        format.json { head :unauthorized }
      end
    end
  end
end
