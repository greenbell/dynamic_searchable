# coding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe "The class (extend Dynamic Searchable)" do
  describe "scope" do
    subject { Article }
    it { should be_respond_to :by_subject }
    it { should be_respond_to :by_body }
  end

  describe "search method" do
    let!(:articles) do
      [Article.create(:subject => "晴れ時々赤塚", :body => "となりの酒井くん"),
       Article.create(:subject => "だみー", :body => "ダミー")]
    end

    it "should respond to search method" do
      Article.should be_respond_to :search
    end

    it "should be searchable using single scope" do
      Article.search(:by_subject => "晴れ").all.should == [articles[0]]
    end

    it "should be searchable using multiple scopes" do
      Article.search(:by_subject => "晴れ", :by_body => "となりの").all.should == [articles[0]]
    end

    it "should be searchable using string-keyed hash" do
      Article.search('by_subject' => "晴れ").all.should == [articles[0]]
    end

    it "should ignore non-existent scope name" do
     Article.search('freeeword' => "晴れ").all.should =~ articles
    end

    it "should skip execution of methods other than scope" do
      Article.search(:delete_all => [articles[0].id.to_s])
      Article.count.should == 2
    end
  end
end
