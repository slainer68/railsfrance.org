require "spec_helper"

describe "paginated links" do
  it "should be Search Engines Optimized" do
    helper.link_to("Premiere page", users_path(:page => 1)).should == "<a href=\"/membres\">Premiere page</a>"
    helper.link_to("Suivante", users_path(:page => 2)).should == "<a href=\"/membres/page/2\">Suivante</a>"
  end
end
