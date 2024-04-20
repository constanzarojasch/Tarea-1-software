Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/teams", to: "team#index" #ya que es team_controler
  get "/teams/:id", to: "team#show"
  get "/teams/:team_id/matches", to: "match#porequipo"
  post "/teams", to: "team#create"
  post "/matches", to: "match#create"
  post "matches/:match_id", to: "match#editar_match"
  get "/matches", to: "match#index"
  get "/matches/:team", to: "match#encontrar_partido_por_equipo"
  delete "/teams/:id", to: "team#eliminate"
  delete "/teams", to: "team#empty"
  patch "/matches/:match_id", to: "match#editar_match"
  get "/players", to: "player#index"
  post "/players/:team_id", to: "player#create"
  get "/players/:player_id/team", to: "player#encontrar_equipo_por_player_id"
  get "/players/topGoals/:quantity", to: "player#encontrar_mejor_jugador"
  get "/players/topAssists/:quantity", to: "player#encontrar_mejor_jugador_asistencia"
  get "/players/topCards/:quantity", to: "player#encontrar_mejor_jugador_sin_cards"
  get "/teams/:team_id/players", to: "player#encontrar_jugadores_por_equipo"
  delete "/teams/matches/low", to: "team#eliminar_peor_equipo"
end
