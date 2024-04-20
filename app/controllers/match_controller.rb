class MatchController < ApplicationController
    before_action :sanitize_params , only: [:create, :editar_match]
    def index
        @matches=Match.all
        render json: match_json(@matches)
    end
    def create
        @match=Match.new(match_params)
        if @match.save
            render json: match_json(@match)
        else
            render json: @match.errors
        end
    end
    def match_params
        params.require(:match).permit(:teamA_id, :teamB_id, :state, :result)
    end
    def porequipo
        @id_team=params[:team_id].to_s
        @matches=Match.where(teamA_id:@id_team)
        @matches2=Match.where(teamB_id:@id_team)
        @allmatches=@matches + @matches2
        @allmatches=@allmatches.sort_by(&:id)
        render json: match_json(@allmatches)
    end 
    def encontrar_partido_por_equipo
        @nombre=params[:team]
        @team=Team.where(name:@nombre)
        @id_team=@team.first.id
        @matches=Match.where(teamA_id:@id_team)
        @matches2=Match.where(teamB_id:@id_team)
        @allmatches=@matches + @matches2
        @allmatches=@allmatches.sort_by(&:id)
        render json: match_json(@allmatches)
    end
    def editar_match
        @id=params[:match_id]
        @match=Match.where(id:@id)
        match_params2.each do |key, value|
            @atributo = key.to_s
            @valor = value
            @match.first.update_attribute(@atributo.to_sym, @valor)
        end
        render json: match_json(@match)
        end
    def match_params2
        params.require(:match).permit(:teamA_id, :teamB_id, :state, :result)
    end
    def sanitize_params
        params[:match][:teamA_id] = params[:match].delete(:teamA) if params[:match][:teamA].present?
        params[:match][:teamB_id] = params[:match].delete(:teamB) if params[:match][:teamB].present?
        params[:match][:state] = params.delete(:state) if params[:state].present?
        params[:match][:result] = params.delete(:result) if params[:result].present?
      end
      def match_json(matches)
        if matches.respond_to?(:map)  # Si `matches` responde al método `map`, asumimos que es una lista
          if matches.length > 1
            return matches.map do |match|
              {
                id: match.id,
                teamA: match.teamA_id,
                teamB: match.teamB_id,
                state: match.state,
                result: match.result,
                created_at: match.created_at,
                updated_at: match.updated_at
              }
            end
          else
            return {
              id: matches.first.id,
              teamA: matches.first.teamA_id,
              teamB: matches.first.teamB_id,
              state: matches.first.state,
              result: matches.first.result,
              created_at: matches.first.created_at,
              updated_at: matches.first.updated_at
            }
          end
        else  # Si no responde a `map`, asumimos que es una instancia individual
          return {
            id: matches.id,
            teamA: matches.teamA_id,
            teamB: matches.teamB_id,
            state: matches.state,
            result: matches.result,
            created_at: matches.created_at,
            updated_at: matches.updated_at
          }
        end
      end
    end 
     

