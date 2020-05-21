require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        shop_name: "Shop Name"
      ),
      Post.create!(
        shop_name: "Shop Name"
      ),
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", text: "Shop Name".to_s, count: 2
  end
end
