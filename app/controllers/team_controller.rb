class TeamController < ApplicationController
    def index
        @teams= Team.all
        render json: @teams 
        end
    def create
        @team= Team.new(team_params)
        if @team.save
            render json: @team
        else
            render json: @team.errors
        end
    end
    def team_params
        params.require(:team).permit(:name,:stadium, :capacity, :city)
    end
    def show
        @team= Team.find(params[:id])
        render json: @team
    end
    def eliminate
        @team=Team.find(params[:id])
        @team.destroy
        render json: {}
    end
    def empty
        @teams=Team.all
        @teams.destroy_all
        render json: @teams
    end
    def eliminar_peor_equipo
        @teams = Team.all.map do |team|
          {
            team: team,
            key: team.id
          }
        end
        
        @teams.each do |team|
          key = team[:key]
          @matches_a = Match.where(teamA_id: key)
          @resultados_a = @matches_a.pluck(:result)
          @suma_a = 0
          @resultados_a.each do |resultado|
            @numero = resultado[0].to_i
            @suma_a += @numero
          end
          
          @matches_b = Match.where(teamB_id: key)
          @resultados_b = @matches_b.pluck(:result)
          @suma_b = 0
          @resultados_b.each do |resultado|
            @numero = resultado[2].to_i
            @suma_b += @numero
          end
          
          team[:key] = @suma_a + @suma_b
        end
        
        @equipos_ordenados1 = @teams.sort_by { |team| team[:key] }
        @equipos_ordenados = @equipos_ordenados1.map { |team| team[:team] }
        
        @equipo_a_eliminar = @equipos_ordenados[0]
        if @equipos_ordenados.length>1
            @equipo_a_eliminar.destroy
            render json: @equipos_ordenados1[0]
        else
            render json: []
        end
        
      end     
        
end
