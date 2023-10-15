require 'rails_helper'

RSpec.describe "lectures/show", type: :view do
  before(:each) do
    assign(:lecture, Lecture.create!(
      title: "Title",
      event: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
  end
end
