# coding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe "The class (extend Dynamic Searchable)" do
  describe "scope" do
    before  { @article = Article.create(:subject => "晴れ時々赤塚", :body => "となりの酒井くん") }
    subject { Article }
    it { should be_respond_to :by_subject }
    it { should be_respond_to :by_body }
  end

  describe "search method" do
    before { @article = Article.create(:subject => "晴れ時々赤塚", :body => "となりの酒井くん") }

    it "should be respond to search method" do
      Article.should be_respond_to :search
    end

    it "should be search using single scope" do
      result = Article.search(:by_subject => "晴れ").first
      result.should eql @article
    end

    it "should be search using multiple scopes" do
      result = Article.search(:by_subject => "晴れ", :by_body => "となりの").first
      result.should eql @article
    end

    it "should skip execution of methods other than scope" do
      Article.search(:delete_all => [@article.id.to_s])
      Article.count.should == 1
    end
  end
end
