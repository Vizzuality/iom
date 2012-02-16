require "rubygems"
require "bundler/setup"
require 'active_support/core_ext'

require File.expand_path("../../../lib/model_changes_recorder", __FILE__)
require File.expand_path("../../support/models/organization", __FILE__)
require File.expand_path("../../support/models/changes_history_record.rb", __FILE__)

describe ModelChangesRecorder do

  let(:organization) { Organization.create(:name => 'Super NGO!') }
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
    change.how.should be == "[{\"name\":[\"Super NGO!\",\"Mega NGO!\"]}]"
  end

  it 'tracks changes in model associations' do
    organization.changes_history_records.should be_empty
    organization.updated_by = user

    thing.should_receive(:to_s).and_return('wadus')
    organization.things << thing

    organization.save
    organization.changes_history_records.should have(1).item

    change = organization.changes_history_records.first
    change.who.id.should be == user.id
    change.who.name.should be == user.name
    change.what.id.should be == organization.id
    change.what.type.should be == organization.class
    change.how.should be == "[{\"things\":{\"new\":[\"wadus\"]}}]"
  end

end
