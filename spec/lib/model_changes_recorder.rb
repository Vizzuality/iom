require "rubygems"
require "bundler/setup"
require 'active_support/core_ext'

require File.expand_path("../../../lib/model_changes_recorder", __FILE__)

class Organization
  include ModelChangesRecorder

  attr_accessor :id, :name, :description, :user
  attr_accessor :changes_history_records, :changes

  def initialize
    self.changes         = []
    self.changes_history_records = []
  end

  def self.create(attributes = {})
    organization = self.new

    organization.id          = 1
    organization.name        = attributes[:name]        rescue nil
    organization.description = attributes[:description] rescue nil

    organization
  end

  def update_attributes(new_attributes = {})
    self.name        = new_attributes[:name]        rescue nil
    self.description = new_attributes[:description] rescue nil
    self.user        = new_attributes[:user]        rescue nil
    puts self.user

    change = {}
    change[:name] = self.name if new_attributes[:name].present?
    changes << change

    save
  end

  def save
    record_changes
  end

end

class Change
  attr_accessor :who, :what, :how

  def self.create!(attributes = {})
    change = self.new
    change.who  = attributes[:who]  rescue nil
    change.what = attributes[:what] rescue nil
    change.how  = attributes[:how]  rescue nil
    change
  end
end

describe ModelChangesRecorder do

  let(:organization) { Organization.create(:name => 'Super NGO!', :description => 'Lorem lorem blablabla') }
  let(:user)         { stub(:id => 1, :name => 'Fulanito')                                                 }

  it 'stores changes made on a single column of some model' do
    organization.changes_history_records.should be_empty
    organization.update_attributes(:name => 'Mega NGO!', :user => user)
    organization.name.should be == 'Mega NGO!'
    organization.changes_history_records.should have(1).item

    change = organization.changes_history_records.first
    change.who.id.should be == user.id
    change.who.name.should be == user.name
    change.what.id.should be == organization.id
    change.what.type.should be == organization.class
    change.how.should be == "[{\"name\":\"Mega NGO!\"}]"
  end

end
