class Admin::PeopleController < AdminController

  layout 'application', only: [:preview]

  def index
    @people = people
  end

  def new
    @person = Person.new
    @teams = Team.all
  end

  def edit
    @person = person
    @teams = Team.all
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:notice] = "#{person} created"
      redirect_to action: "index"
    else
      respond_with(:admin, @person)
    end
  end

  def update
    person.attributes = person_params
    if person.save
      flash[:notice] = "#{person} updated"
      redirect_to action: "index"
    else
      respond_with(:admin, person)
    end
  end

private

  def people
    @people ||= Person.all
  end

  def person
    @person ||= people.slug_find(params[:id])
    unless @person
      redirect_to admin_people_path
    end
    @person
  end

  def person_params
    params.require(:person).permit(:first_name,
                                   :last_name,
                                   :display_name,
                                   :job_title,
                                   :biography_short,
                                   :biography,
                                   :avatar_original,
                                   :page,
                                   :slug,
                                   team_ids: [])
  end

end
