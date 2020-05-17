require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      shop_name: "MyString"
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input[name=?]", "post[shop_name]"
    end
  end
end
