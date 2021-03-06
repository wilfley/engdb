class EcnsController < ApplicationController
  handles_sortable_columns
  before_filter :eng_check, only: [:new, :create, :update]
  before_filter :admin_check, only: [:destroy]
  # GET /ecns
  # GET /ecns.json
  def index
      order = sortable_column_order, "ecn_number desc"
    if params[:ecns].nil?
       @ecns = Ecn.paginate page: params[:page], order: order, per_page: 100
    else
       @ecns = Ecn.by_ecn_number(params[:ecns][:ecn_number])\
         .by_ecn_type(params[:ecns][:ecn_type])\
         .by_drawing_number(params[:ecns][:drawing_number])\
         .by_user_name(params[:ecns][:user_name])\
         .by_pump_model(params[:ecns][:pump_model])\
         .by_created_before(params[:ecns]['created_before(1i)'], params[:ecns]['created_before(2i)'], params[:ecns]['created_before(3i)'])\
         .by_created_after(params[:ecns]['created_after(1i)'], params[:ecns]['created_after(2i)'], params[:ecns]['created_after(3i)'])\
         .paginate page: params[:page], order: order, per_page: 100

        #    .by_part_type(params[:ecns][:part_type])\

         
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ecns }
    end
  end

  def index_open
    order = sortable_column_order, "ecn_number desc"
    @ecns = Ecn.by_open_ecns.paginate page: params[:page], order: order, per_page: 100
    
    respond_to do |format|
      format.html { render :template => "ecns/index" }
      format.json { render json: @ecn }
    end
  end


  # GET /ecns/1
  # GET /ecns/1.json
  def show
    @ecns = Ecn.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ecn }
    end
  end

  # GET /ecns/new
  # GET /ecns/new.json
  def new
    
    @ecn = Ecn.new
    @ecn = @ecn.incrament(@ecn)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ecn }
    end
  end

  # GET /ecns/1/edit
  def edit
    @ecn = Ecn.find(params[:id])
  end

  # POST /ecns
  # POST /ecns.json
  def create

    @ecn = Ecn.new(params[:ecn])
    @ecn.status = false

    respond_to do |format|
      if @ecn.save
        format.html { redirect_to @ecn, notice: 'Ecn was successfully created.' }
        format.json { render json: @ecn, status: :created, location: @ecn }
      else
        format.html { render action: "new" }
        format.json { render json: @ecn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ecns/1
  # PUT /ecns/1.json
  def update
    @ecn = Ecn.find(params[:id])

    respond_to do |format|
      if @ecn.update_attributes(params[:ecn])
        format.html { redirect_to @ecn, notice: 'Ecn was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ecn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ecns/1
  # DELETE /ecns/1.json
  def destroy
    @ecn = Ecn.find(params[:id])
    @ecn.destroy

    respond_to do |format|
      format.html { redirect_to ecns_url }
      format.json { head :no_content }
    end
  end
  
  def submit
      
    @ecn = Ecn.find(params[:id])
    @email = params[:email]
    @message = @email[:message]
    @email_list = EmailList.all
    @additional_emails = @email[:recipient]
    @subject = @email[:subject]
    
    respond_to do |format|
      EcnNotifier.submit_additional(@ecn, @message, @additional_emails, @subject).deliver if @additional_emails != ""
      EcnNotifier.submit_engineering(@ecn, @message, @subject).deliver if @ecn.distribute_engineering?
      EcnNotifier.submit_purchasing(@ecn, @message, @subject).deliver if @ecn.distribute_purchasing?
      EcnNotifier.submit_manufacturing(@ecn, @message, @subject).deliver if @ecn.distribute_manufacturing?
      EcnNotifier.submit_qantel(@ecn, @message, @subject).deliver if @ecn.distribute_qantel?
      EcnNotifier.submit_planning(@ecn, @message, @subject).deliver if @ecn.distribute_planning?
      format.html { redirect_to home_url, alert: "Ecn has been submitted for approval." }
      format.json { render json: @ecns }
    end
  end
  
  def close
    @ecn = Ecn.find(params[:id])
    @email = params[:email]
    @message = @email[:message]
    @ecn = @ecn.close_status(@ecn)
    @additional_emails = @email[:recipient]
    @subject = @email[:subject]
    
    respond_to do |format|
      EcnNotifier.close_additional(@ecn, @message, @additional_emails, @subject).deliver if @additional_emails != ""
      EcnNotifier.close_engineering(@ecn, @message, @subject).deliver if @ecn.distribute_engineering?
      EcnNotifier.close_purchasing(@ecn, @message, @subject).deliver if @ecn.distribute_purchasing?
      EcnNotifier.close_manufacturing(@ecn, @message, @subject).deliver if @ecn.distribute_manufacturing?
      EcnNotifier.close_qantel(@ecn, @message, @subject).deliver if @ecn.distribute_qantel?
      EcnNotifier.close_planning(@ecn, @message, @subject).deliver if @ecn.distribute_planning?
      EcnNotifier.close_sales(@ecn, @message, @subject).deliver if @ecn.distribute_sales?
      EcnNotifier.close_inventory(@ecn, @message, @subject).deliver if @ecn.distribute_inventory?
      EcnNotifier.close_quality(@ecn, @message, @subject).deliver if @ecn.distribute_quality?
      EcnNotifier.close_india(@ecn, @message, @subject).deliver if @ecn.distribute_india?
      EcnNotifier.close_finance(@ecn, @message, @subject).deliver if @ecn.distribute_finance?
      @ecn.update_attributes(params[:ecn])
      format.html { redirect_to ecns_url, alert: "Ecn has been closed.  A confirmation email has been sent to the appropriate personnel." }
      format.json { render json: @ecns }
    end
  end
end
