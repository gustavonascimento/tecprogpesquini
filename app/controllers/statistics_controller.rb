# File: statistics_controller.rb
# Purpouse: Controls the actions relative to the statistics model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class StatisticsController < ApplicationController

  # global variables
  
  # list that saves all the states.
  @@states_list = State.all_states

  # list that saves all the years.
  @@all_years_list = Sanction.all_years

  # list that saves all the sanctions.
  @@sanction_type_list = SanctionType.all_sanction_types
  
  # empty method.
  def  index
    
  end

  # manipulates the data of the enterprises with more sanctions.
  def most_sanctioned_ranking
    
    # Stores the most sanctioned enterprises in a array
    enterprise_group_array = Enterprise.most_sanctioned_ranking

    # Stores the first position of the previous array of enterprises.
    @enterprise_group = enterprise_group_array[0]

    # Stores the second position of the previous array of enterprises.
    @enterprise_group_count = enterprise_group_array[1]
    
    return @enterprise_group_count

  end

  # manipulates the data of the most paid enterprises.
  def most_paymented_ranking

    # Gives a false value to a variable to use it later, making the pagination.
    @all = false

    if params[:all_years_list]
      @all = true

      # Stores the enterprises by page, making it have only some enterprises in the page.
      @enterprises = Enterprise.featured_payments.paginate(:page => params[:page], :per_page => 20)
    
    else

      # Stores the enterprises by page, making it have only some enterprises in the page.
      @enterprises = Enterprise.featured_payments(10)

    end

    return @enterprises

  end

  # aggregates the enterprises by the group it belongs
  def enterprise_group_ranking

    #Stores the quantity of sanctions os the enterprise.
    @quantidade = params[:sanctions_count]

    # Stores the enterprises by page, making it have only some enterprises in the page.
    @enterprises = Enterprise.where(sanctions_count: @quantidade).paginate(:page => params[:page], :per_page => 10)

    return @enterprises

  end

  # aggregates the payments by the group it belongs
  def payment_group_ranking

    #Stores the quantity of payments os the enterprise.
    @quantidade = params[:payments_count]

    # Stores the enterprises by page, making it have only some enterprises in the page.
    @enterprises = Enterprise.where(payments_count: @quantidade).paginate(:page => params[:page], :per_page => 10)
  
    return @enterprises

  end

  # manipulate data to build the graphic of sanctions by state.
  def sanction_by_state_graph

    # Stores the list of all states.
    gon.states = @@states_list

    #Stores the data about the sanctions, by state.
    gon.dados = total_by_state

    #Stores the title of the graph.
    titulo = "Gráfico de Sanções por Estado"

    #The variable that receives the graph, through the gem.
    @chart = LazyHighCharts::HighChart.new('graph') do |plotted_graph|
      plotted_graph.title(:text => titulo)
      if(params[:year_].to_i != 0)
         plotted_graph.title(:text => params[:year_].to_i )
      else
        #nothing to do
      end

      # The following lines will categorize the graph, 
      # ... naming the ṕarts of it, and categorizing.
      plotted_graph.xAxis(:categories => @@states_list)
      plotted_graph.series(:name => "Número de Sanções", :yAxis => 0, :data => total_by_state)
      plotted_graph.yAxis [
      {:title => {:text => "Sanções", :margin => 30} },
      ]
      plotted_graph.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      plotted_graph.chart({:defaultSeriesType=>"column"})

    end

  end

 # manipulate data to build the graphic of sanctions by type.
 def sanction_by_type_graph

     #Stores the title of the graph of sanctions.
    titulo = "Gráfico Sanções por Tipo"

    #The variable that receives the graph, through the gem.
    @chart = LazyHighCharts::HighChart.new('pie') do |plotted_graph|
        plotted_graph.chart({:defaultSeriesType=>"pie" ,:margin=> [50, 10, 10, 10]} )
        plotted_graph.series({
                 :type=> 'pie',
                 :name=> 'Sanções Encontradas',
                 :data => total_by_type
        })
        plotted_graph.options[:title][:text] = titulo
        plotted_graph.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto', :right=> '50px', :top=> '100px'})
        plotted_graph.plot_options(:pie=>{
          :allowPointSelect=>true,
          :cursor=>"pointer" ,
          :dataLabels=>{
            :enabled=>true,
            :color=>"black",
            :style=>{
            :font=>"12px Trebuchet MS, Verdana, sans-serif"
            }
          }
        })
    end

    if (!@states)

      # Its a clone of the state varibale, wich stores all the states. 
      @states = @@states_list.clone
      @states.unshift("Todos")
    else
      #nothing to do
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end

    return @chart

  end
    
  # shows the total of sanctions by state.
  def total_by_state()

    # Initiates a variablçe that will later on store the resul of how much sanction there is by state.
    results = []

    # Variable that stores all the years analysed by the program, 1988, 1991 - 2015; 
    @years = @@all_years_list

    @@states_list.each do |state_item|

      # Stores the state searched by its abbreviation.
      state = State.find_by_abbreviation("#{state_item}")

      # Have relations to the precious state variable, storing the sanctions of the state.
      sanctions_by_state = Sanction.where(state_id: state[:id])

      # Variable initiated to store the year that it's selected by the user.
      selected_year = []

      if(params[:year_].to_i != 0)
        sanctions_by_state.each do |sanction|
          if(sanction.initial_date.year ==  params[:year_].to_i)
            selected_year << sanction
          else
            #nothing to do
          end
        end
        results << (selected_year.count)
      else
        results << (sanctions_by_state.count)
      end
    end

    assert results.empty?, "List can't be empty"

    return results

  end

  # shows the total of sanctions by it type.
  def total_by_type()

    # Initiates a variablçe that will later on store the resul of how much sanction there is by type of sanction.
    results = []

    # Initiates a variablçe that will later on store the resul of how much sanction there is by type of sanction.
    results2 = []

    # Stores a integer that will be iterated.
    cont = 0

     # Stores the state searched by its abbreviation.
    state = State.find_by_abbreviation(params[:state_])

    @@sanction_type_list.each do |sanction_type|
      
      # Stores the sanction searched by its description.
      sanction = SanctionType.find_by_description(sanction_type[0])

      # Stores the quantity os sanctions of the type stored before.
      sanctions_by_type = Sanction.where(sanction_type:  sanction)
      
      if (params[:state_] && params[:state_] != "Todos")
        sanctions_by_type = sanctions_by_type.where(state_id: state[:id])
      else
        #nothing to do
      end
      
      cont = cont + (sanctions_by_type.count)
      results2 << sanction_type[1]
      results2 << (sanctions_by_type.count)
      results << results2
      results2 = []

      assert results2.empty?, "list2 can not be empty"
    
    end
    
    results2 << "Não Informado"
      if (params[:state_] && params[:state_] != "Todos")
        total =Sanction.where(state_id: state[:id] ).count
      else
        total = Sanction.count
      end
    
    results2 << (total - cont)
    results << results2
    results = results.sort_by { |i| i[0] }
    
    assert results.empty?, "List can't be empty"
    return results

  end

end
