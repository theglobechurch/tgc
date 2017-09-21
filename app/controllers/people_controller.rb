class PeopleController < ApplicationController
  layout 'application'

  def show
    @person = person

    unless @person && @person.page == true
      render file: Rails.root.join('public', '404.html'),
             status: 404,
             layout: false
      return
    end

    @banner = {
      'title' => @person.display_name,
      'size' => 'none',
    }
  end

private

  def people
    @people ||= Person.all
  end

  def person
    @person ||= people.slug_find(params[:id])
  end

end
