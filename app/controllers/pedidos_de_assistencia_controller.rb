class PedidosDeAssistenciaController < ApplicationController
  def selecionar_cliente
    if request.post?
      @cliente = Cliente.find(params[:cliente][:id])
      if @cliente
        redirect_to :action => :new, :id => @cliente.id
      end
    else
      @cliente = Cliente.new
    end
  end

  def index

 	@pedidos_de_assistencia = PedidoDeAssistencia.find(:all, :include => [:cliente], :offset => params[:start], :limit => params[:limit] )
    @dto = Hash.new
    @dto[:total] = PedidoDeAssistencia.count
    @dto[:results] = @pedidos_de_assistencia

    #@pedidos_de_assistencia = Pedido.all
    @qtd_pedidos = @pedidos_de_assistencia.count

    respond_to do |format|
	  format.json { render :layout => false,
                           :json => @dto.to_json }
      format.html # index.html.erb
      format.xml  { render :xml => @pedidos_de_assistencia }
    end
  end

  def show
    @pedido_de_assistencia = PedidoDeAssistencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pedido_de_assistencia }
    end
  end

  def new
    @pedido_de_assistencia = PedidoDeAssistencia.new
    @pedido_de_assistencia.cliente = Cliente.find(:first)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pedido_de_assistencia }
    end
  end

  def edit
    @pedido_de_assistencia = PedidoDeAssistencia.find(params[:id])
  end

  def create
    @pedido_de_assistencia = PedidoDeAssistencia.new(params[:pedido_de_assistencia])

    @pedido_de_assistencia.operador_id = current_user.id # Deverá vir na session
    respond_to do |format|
      if @pedido_de_assistencia.save
        flash[:notice] = 'Pedido Cadastrado com Sucesso'
        format.html { redirect_to(@pedido_de_assistencia) }
        format.xml  { render :xml => @pedido_de_assistencia, :status => :created, :location => @pedido_de_assistencia }
      else
        render :text => @pedido_de_assistencia.errors.full_messages.to_s + @pedido_de_assistencia.data.to_s
        return
        flash[:notice] = @pedido_de_assistencia.errors
        format.html { render :action => "new" }
        format.xml  { render :xml => @pedido_de_assistencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @pedido_de_assistencia = PedidoDeAssistencia.find(params[:id])

    respond_to do |format|
      if @pedido_de_assistencia.update_attributes(params[:pedido_de_assistencia])
        flash[:notice] = 'Pedido Atualizado com Sucesso'
        format.html { redirect_to(@pedido_de_assistencia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pedido_de_assistencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @pedido_de_assistencia = PedidoDeAssistencia.find(params[:id])
    @pedido_de_assistencia.destroy

    respond_to do |format|
      format.html { redirect_to(pedidos_de_assistencia_url) }
      format.xml  { head :ok }
    end
  end


  def impressao
    @pedido_de_assistencia = PedidoDeAssistencia.find(params[:id])

    respond_to do |format|
      format.html # impressao.html.erb
      format.xml  { render :xml => @pedido_de_assistencia }
    end
  end
end

