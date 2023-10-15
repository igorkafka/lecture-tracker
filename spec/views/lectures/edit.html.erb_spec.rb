require 'rails_helper'

RSpec.describe "lectures/edit", type: :view do
  let(:lecture) {
    Lecture.create!(
      title: "MyString",
      event: nil
    )
  }

  before(:each) do
    assign(:lecture, lecture)
  end

  it "renders the edit lecture form" do
    render

    assert_select "form[action=?][method=?]", lecture_path(lecture), "post" do

      assert_select "input[name=?]", "lecture[title]"

      assert_select "input[name=?]", "lecture[event_id]"
    end
  end
end
