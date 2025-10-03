require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'validations' do
    it 'requires a name' do
      campaign = Campaign.new(description: "Test")
      expect(campaign).not_to be_valid
      expect(campaign.errors[:name]).to include("can't be blank")
    end

    it 'validates name length' do
      campaign = Campaign.new(name: 'a' * 101)
      expect(campaign).not_to be_valid
    end

    it 'is valid with valid attributes' do
      campaign = Campaign.new(name: "Test Campaign", status: "active")
      expect(campaign).to be_valid
    end
  end

  describe 'enums' do
    it 'has status enum' do
      expect(Campaign.statuses).to eq({ "active" => 0, "completed" => 1, "archived" => 2 })
    end

    it 'defaults status to active' do
      campaign = Campaign.create!(name: "Test")
      expect(campaign.status).to eq("active")
    end
  end

  describe 'associations' do
    it 'has many tasks' do
      association = Campaign.reflect_on_association(:tasks)
      expect(association.macro).to eq(:has_many)
    end

    it 'deletes associated tasks when deleted' do
      # This will fail until Task model exists
      skip "Task model not yet created" unless defined?(Task)

      campaign = Campaign.create!(name: "Test Campaign")
      task = campaign.tasks.create!(title: "Test Task")

      expect { campaign.destroy }.to change { Task.count }.by(-1)
    end
  end
end
