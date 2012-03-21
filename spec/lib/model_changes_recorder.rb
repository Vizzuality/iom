require "rubygems"
require "bundler/setup"
require 'active_support/core_ext'

require File.expand_path("../../../lib/model_changes_recorder", __FILE__)
require File.expand_path("../../support/models/organization", __FILE__)
require File.expand_path("../../support/models/changes_history_record.rb", __FILE__)

describe ModelChangesRecorder do

  let(:organization) { Organization.create(:name => 'Super NGO!', :description => nil) }
  let(:user)         { stub(:id => 1, :name => 'Fulanito')                                                 }
  let(:thing)        { stub(:name => 'wadus') }

  it 'stores changes made on a single column of some model' do
    organization.changes_history_records.should be_empty
    organization.updated_by = user
    organization.update_attributes(:name => 'Mega NGO!')
    organization.name.should be == 'Mega NGO!'
    organization.changes_history_records.should have(1).item

    change = organization.changes_history_records.first
    change.who.id.should be == user.id
    change.who.name.should be == user.name
    change.what.id.should be == organization.id
    change.what.type.should be == organization.class
    change.how.should be == "{\"name\":[\"Super NGO!\",\"Mega NGO!\"]}"
  end

  it 'tracks changes in model associations' do
    organization.changes_history_records.should be_empty
    organization.updated_by = user

    organization.things << thing

    organization.save
    organization.changes_history_records.should have(1).item

    change = organization.changes_history_records.first
    change.who.id.should be == user.id
    change.who.name.should be == user.name
    change.what.id.should be == organization.id
    change.what.type.should be == organization.class
    change.how.should be == "{\"r_spec/mocks/mocks\":[[{\"new\":\"wadus\"}]]}"
  end

  it "shouldn't track empty changes" do
    organization.changes_history_records.should be_empty
    organization.updated_by = user
    organization.update_attributes(:description => '')
    organization.description.should be == ''
    organization.changes_history_records.should have(0).item
    organization.update_attributes(:budget => 0.0)
    organization.budget.should be == 0.0
    organization.changes_history_records.should have(1).item
  end


end
