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
  @@sanjana = Sanction.all_years

  # list that saves all the sanctions.
  @@sanction_type_list = SanctionType.all_sanction_types
  
  # empty method.
  def  index
    
  end

  # manipulates the data of the enterprises with more sanctions.
  def most_sanctioned_ranking
    
    enterprise_group_array = Enterprise.most_sanctioned_ranking
    @enterprise_group = enterprise_group_array[0]
    @enterprise_group_count = enterprise_group_array[1]

  end

  # manipulates the data of the most paid enterprises.
  def most_paymented_ranking

    @all = false

    if params[:sanjana]
      @all = true
      @enterprises = Enterprise.featured_payments.paginate(:page => params[:page], :per_page => 20)
    else
      @enterprises = Enterprise.featured_payments(10)
    end

  end

  # aggregates the enterprises by the group it belongs
  def enterprise_group_ranking

    @quantidade = params[:sanctions_count]
    @enterprises = Enterprise.where(sanctions_count: @quantidade).paginate(:page => params[:page], :per_page => 10)

  end

  # aggregates the payments by the group it belongs
  def payment_group_ranking

    @quantidade = params[:payments_count]
    @enterprises = Enterprise.where(payments_count: @quantidade).paginate(:page => params[:page], :per_page => 10)
  
  end

  # manipulate data to build the graphic of sanctions by state.
  def sanction_by_state_graph

    gon.states = @@states_list
    gon.dados = total_by_state
    titulo = "Gráfico de Sanções por Estado"
    @chart = LazyHighCharts::HighChart.new('graph') do |plotted_graph|
      plotted_graph.title(:text => titulo)
      if(params[:year_].to_i != 0)
         plotted_graph.title(:text => params[:year_].to_i )
      else
        #nothing to do
      end

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

    titulo = "Gráfico Sanções por Tipo"
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
      @states = @@states_list.clone
      @states.unshift("Todos")
    else
      #nothing to do
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end

  end
    
  # shows the total of sanctions by state.
  def total_by_state()

    results = []
    @years = @@sanjana

    @@states_list.each do |state_item|
      state = State.find_by_abbreviation("#{state_item}")
      sanctions_by_state = Sanction.where(state_id: state[:id])
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

     return results

  end

  # shows the total of sanctions by it type.
  def total_by_type()

    results = []
    results2 = []
    cont = 0

    state = State.find_by_abbreviation(params[:state_])

    @@sanction_type_list.each do |sanction_type|
      sanction = SanctionType.find_by_description(sanction_type[0])
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
    return results

  end

end
