class Admin::TeamsController < AdminController

  layout 'application', only: [:preview]

  def index
    @teams = teams
  end

  def new
    @teams = teams
    @team = Team.new
  end

  def edit
    @teams = teams
    @team = team
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:notice] = "#{team} created"
      redirect_to action: "index"
    else
      respond_with(:admin, @team)
    end
  end

  def update
    team.attributes = team_params
    if team.save
      flash[:notice] = "#{team} updated"
      redirect_to action: "index"
    else
      respond_with(:admin, team)
    end
  end

private

  def teams
    @teams ||= Team.all
  end

  def team
    @team ||= teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name,
                                 :description,
                                 :teams_id)
  end

end
