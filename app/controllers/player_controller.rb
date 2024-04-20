class PlayerController < ApplicationController
   def index
    @players= Player.all
    render json: @players
   end
    def create
        @team_id=Team.find(params[:team_id].to_i)
        @json= {"team": @team_id}
        @cadena_completa= player_params.merge(@json)
        @player= Player.new(@cadena_completa)
        
        if @player.save
            render json: @player
        else
            render json: @player.errors
        end
    end
    def player_params
        params.require(:player).permit(:name,:goal,:assist,:card)
    end
    def encontrar_equipo_por_player_id
        @player_id=params[:player_id]
        @player= Player.find(@player_id)
        @team=Team.find(@player.team_id)
        render json: @team
    end   
    def encontrar_mejor_jugador
        @cantidad=params[:quantity].to_i
        @jugadores=Player.all.map do |player|
            {
                player: player,
                key: player.goal
            }
        end
        @jugadores_ordenados=@jugadores.sort_by {|player| player[:key]}.reverse
        @jugadores_ordenados = @jugadores_ordenados.map { |player| player[:player] }
        if @cantidad == 1
            @mejor_jugador=@jugadores_ordenados[0]
            render json: @mejor_jugador
        else 
            @mejores_jugadores=@jugadores_ordenados.take(@cantidad)
            render json: @mejores_jugadores
        end
    end
    def encontrar_mejor_jugador_asistencia
        @cantidad=params[:quantity].to_i
        @jugadores=Player.all.map do |player|
            {
                player: player,
                key: (player.assist.to_f)/(player.assist+player.goal)
            }
        end
        @jugadores_ordenados=@jugadores.sort_by {|player| player[:key]}.reverse
        @jugadores_ordenados = @jugadores_ordenados.map { |player| player[:player] }
        if @cantidad == 1
            @mejor_jugador=@jugadores_ordenados[0]
            render json: @mejor_jugador
        else 
            @mejores_jugadores=@jugadores_ordenados.take(@cantidad)
            render json: @mejores_jugadores
        end
    end
    def encontrar_mejor_jugador_sin_cards
        @cantidad = params[:quantity].to_i
        @jugadores = Player.all.map do |player|
          {
            player: player,
            key_card: player.card,
            key_id: player.id
          }
        end
        @jugadores_ordenados = @jugadores.sort do |a, b|
            comp = a[:key_card] <=> b[:key_card]
            comp.zero? ? (a[:key_id] <=> b[:key_id]) : comp
          end
        @jugadores_ordenados = @jugadores_ordenados.map { |jugador| jugador[:player] }
      
        if @cantidad == 1
          @mejor_jugador = @jugadores_ordenados[0]
          render json: @mejor_jugador
        else 
          @mejores_jugadores = @jugadores_ordenados.take(@cantidad)
          render json: @mejores_jugadores
        end
      end
      def encontrar_jugadores_por_equipo
        @team_id= params[:team_id]
        @jugadores= Player.where(team_id: @team_id)
        if @jugadores.length>1
            render json: @jugadores
        else
            if @jugadores.length==0
                render json: []
            else
                render json: @jugadores.first
            end
        end
      end
end

