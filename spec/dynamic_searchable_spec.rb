# coding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe DynamicSearchable do
  describe "scopes" do
    subject { Article }
    it { should respond_to :by_subject }
    it { should be_respond_to :by_body }
  end

  describe ".searchable_scopes" do
    it "lists up all scope names" do
      expect(Article.searchable_scopes).to eq [:by_id, :by_subject, :by_body]
    end
  end

  describe ".search" do
    let!(:articles) do
      [Article.create(:subject => "晴れ時々赤塚", :body => "となりの酒井くん"),
       Article.create(:subject => "だみー", :body => "ダミー")]
    end

    it "responds to :search" do
      expect(Article).to respond_to :search
    end

    it "is searchable using single scope" do
      expect(Article.search(:by_subject => "晴れ").all).to eq [articles[0]]
    end

    it "is searchable using multiple scopes" do
      expect(Article.search(:by_subject => "晴れ", :by_body => "となりの").all).to eq [articles[0]]
    end

    it "is searchable using string-keyed hash" do
      expect(Article.search('by_subject' => "晴れ").all).to eq [articles[0]]
    end

    it "ignores non-existent scope name" do
     expect(Article.search('freeeword' => "晴れ").all).to match_array articles
    end

    it "skips execution of methods other than scope" do
      Article.search(:delete_all => [articles[0].id.to_s])
      expect(Article.count).to eq 2
    end

    it "allows search of the scope that is decleared before 'extend DynamicSearchable'" do
      expect(Article.search(:by_id => [articles[0].id]).all).to eq articles.first(1)
    end
  end
end
