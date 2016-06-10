# File: statistics_controller.rb
# Purpouse: Controls the actions relative to the statistics model.
# License: GPL v3
# Group 10 Tecprog
# FGA - Universidade de Brasília - Campus Gama

class StatisticsController < ApplicationController

  # global variables
  
  # list that saves all the states from brasil, including 'Distrito Federal'.
  @@states_list = State.all_states

  # list that saves all the years in the program, since 1988.
  @@all_years_list = Sanction.all_years

  # list that saves all the type of sanctions regarding a enterprise.
  @@sanction_type_list = SanctionType.all_sanction_types
  
  # empty method.
  def  index
    
  end

  # manipulates the data of the enterprises with the most sanctions.
  # @param @enterprise_group_count
  def most_sanctioned_ranking
    
    # stores the most sanctioned enterprises in a array
    enterprise_group_array = Enterprise.most_sanctioned_ranking

    # stores the first position of the previous array of enterprises.
    @enterprise_group = enterprise_group_array[0]

    # stores the second position of the previous array of enterprises.
    @enterprise_group_count = enterprise_group_array[1]
    
    return @enterprise_group_count

    assert @enterprise_group_count.empty?, "Group of enterprises mus not be null"

  end

  # manipulates the data of the most paid enterprises.
  # @param @enterprises_by_payments
  def most_paymented_ranking

    # gives a false value to a variable to use it later, making the pagination.
    @list_of_years = false

    Preconditions.check_not_nil(:all_years_list)

    if params[:all_years_list]
      @list_of_years = true

      # stores the enterprises by page, making it have only some enterprises in the page, 
      # ...int this case , 20.
      @enterprises_by_payments = Enterprise.featured_payments.paginate(:page => params[:page], 
                                                                       :per_page => 20)
    
    else

      # stores the enterprises by page, making it have only some enterprises in the page.
      @enterprises_by_payments = Enterprise.featured_payments(20)

    end

    return @enterprises_by_payments

    assert @enterprises_by_payments.empty?, "Enterprises groups must not be null"

  end

  # aggregates the enterprises by the group it belongs
  # @param @enterprises_by_sanctions
  def enterprise_group_ranking

    # stores the quantity of sanctions os the enterprise.
    @quantity_of_sanctions_in_enterprise = params[:sanctions_count]

    # stores the enterprises by page, making it have only some enterprises in the page.
    @enterprises_by_sanctions = Enterprise.where(sanctions_count: @quantity_of_sanctions_in_enterprise)
                                .paginate(:page => params[:page], :per_page => 10)

    return @enterprises_by_sanctions

    assert @enterprises_by_sanctions.empty?, "Enterprises groups must not be null"

  end

  # aggregates the payments by the group it belongs
  # @param @enterprises_by_payments_group
  def payment_group_ranking

    # stores the quantity of payments of the enterprise.
    @payments_quantity = params[:payments_count]

    assert @payments_quantity < 0, "Number of payments less than 0"

    # stores the enterprises by page, making it have only some enterprises in the page.
    @enterprises_by_payments_group = Enterprise.where(payments_count: @payments_quantity)
                                    .paginate(:page => params[:page], :per_page => 10)
  
    return @enterprises_by_payments_group

    assert @payments_quantity.empty?, "Quantity of payments must not be null"
    assert @enterprises_by_payments_group.empty?, "Enterprises groups must not be null"

  end

  # manipulate data to build the graphic of sanctions by state.
  # @param @chart
  def sanction_by_state_graph

    # stores the list of all states.
    gon.states = @@states_list

    # stores the data about the sanctions, by state.
    gon.dados = total_by_state

    # stores the title of the graph.
    titulo = "Gráfico de Sanções por Estado"

    # the variable that receives the graph, through the gem.
    @chart = LazyHighCharts::HighChart.new('graph') do |plotted_graph|
      plotted_graph.title(:text => titulo)
      if(params[:year_].to_i != 0)
         plotted_graph.title(:text => params[:year_].to_i )
      else
        # nothing to do
      end

      # the following lines will categorize the graph, 
      # ... naming the ṕarts of it, and categorizing.
      plotted_graph.xAxis(:categories => @@states_list)
      plotted_graph.series(:name => "Número de Sanções", :yAxis => 0, :data => total_by_state)
      plotted_graph.yAxis [
      {:title => {:text => "Sanções", :margin => 30} },
      ]
      plotted_graph.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      plotted_graph.chart({:defaultSeriesType=>"column"})

    end

    return @chart

  end

 # manipulate data to build the graphic of sanctions by type.
 # @param @chart
 def sanction_by_type_graph

    # stores the title of the graph of sanctions.
    title_of_graph = "Gráfico Sanções por Tipo"

    # the variable that receives the graph, through the gem.
    @chart = LazyHighCharts::HighChart.new('pie') do |plotted_graph|
        plotted_graph.chart({:defaultSeriesType=>"pie" ,:margin=> [50, 10, 10, 10]} )
        plotted_graph.series({
                 :type=> 'pie',
                 :name=> 'Sanções Encontradas',
                 :data => total_by_type
        })
        plotted_graph.options[:title][:text] = title_of_graph
        plotted_graph.legend(:layout=> 'vertical',:style=> {
          :left=> 'auto',
          :bottom=> 'auto',
          :right=> '50px',
          :top=> '100px'
          })
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

    if (!@states_of_brazil)

      # its a clone of the state variable, wich stores all the states. 
      @states_of_brazil = @@states_list.clone
      @states_of_brazil.unshift("Todos")
    
    else
      #nothing to do
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end

    return @chart

    assert @chart.empty?, "List can't be empty"


  end
    
  # shows the total of sanctions by state.
  # @param sanctions_in_state
  def total_by_state()

    # initiates a variable that will later on store the resul of how much sanction there is by state.
    sanctions_in_state = []

    # variable that stores all the years analysed by the program, 1988, 1991 - 2015; 
    @years = @@all_years_list

    @@states_list.each do |state_item|

      # stores the state searched by its abbreviation.
      state = State.find_by_abbreviation("#{state_item}")

      # have relations to the precious state variable, storing the sanctions of the state.
      sanctions_by_state = Sanction.where(state_id: state[:id])

      # variable initiated to store the year that it's selected by the user.
      selected_year = []

      if(params[:year_].to_i != 0)
        sanctions_by_state.each do |sanction|
          if(sanction.initial_date.year ==  params[:year_].to_i)
            selected_year << sanction
          else
            #nothing to do
          end
        end
        sanctions_in_state << (selected_year.count)
      else
        sanctions_in_state << (sanctions_by_state.count)
      end
    end

    return sanctions_in_state

    assert sanctions_in_state.empty?, "List can't be empty"

  end

  # shows the total of sanctions by it type.
  # @param results_of_sanction_by_type
  def total_by_type()

    # initiates a variable that will later on store the resul of 
    # ...how much sanction there is by type of sanction.
    results_of_sanction_by_type = []

    # initiates a variable that will later on store the resul of 
    # ...how much sanction there is by type of sanction.
    results_of_second_search_of_sanctions = []

    # stores a integer that will be iterated.
    iterator = 0

     # stores the state searched by its abbreviation.
    state = State.find_by_abbreviation(params[:state_])

    @@sanction_type_list.each do |sanction_type|
      
      # stores the sanction searched by its description.
      sanction_by_description = SanctionType.find_by_description(sanction_type[0])

      # stores the quantity os sanctions of the type stored before.
      sanctions_by_type = Sanction.where(sanction_type:  sanction_by_description)
      
      if (params[:state_] && params[:state_] != "Todos")
        sanctions_by_type = sanctions_by_type.where(state_id: state[:id])
      else
        #nothing to do
      end
      
      iterator = iterator + (sanctions_by_type.count)
      results_of_second_search_of_sanctions << sanction_type[1]
      results_of_second_search_of_sanctions << (sanctions_by_type.count)
      results_of_sanction_by_type << results_of_second_search_of_sanctions
      results_of_second_search_of_sanctions = []

      assert results_of_second_search_of_sanctions.empty?, "Result of second search can not be empty"
    
    end
    
    results_of_second_search_of_sanctions << "Não Informado"

      if (params[:state_] && params[:state_] != "Todos")
        total =Sanction.where(state_id: state[:id] ).count
      else
        total = Sanction.count
      end
    
    results_of_second_search_of_sanctions << (total - iterator)
    results_of_sanction_by_type << results_of_second_search_of_sanctions
    results_of_sanction_by_type = results_of_sanction_by_type.sort_by { |i| i[0] }
    
    return results_of_sanction_by_type

    assert results_of_sanction_by_type.empty?, "Results of sanction can't be empty"

  end

end
