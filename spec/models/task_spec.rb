require 'rails_helper'

# These tests will fail until you create the Task model
# Run migrations after generating the Task model
RSpec.describe Task, type: :model do
  describe 'validations' do
    it 'requires a title' do
      task = Task.new(campaign_id: 1)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'validates title length' do
      task = Task.new(title: 'a' * 201, campaign_id: 1)
      expect(task).not_to be_valid
    end

    it 'requires a campaign' do
      task = Task.new(title: "Test Task")
      expect(task).not_to be_valid
      expect(task.errors[:campaign]).to include("must exist")
    end

    it 'is valid with valid attributes' do
      campaign = Campaign.create!(name: "Test Campaign")
      task = Task.new(title: "Test Task", campaign: campaign)
      expect(task).to be_valid
    end
  end

  describe 'enums' do
    it 'has status enum' do
      expect(Task.statuses).to eq({ "todo" => 0, "in_progress" => 1, "done" => 2 })
    end

    it 'has priority enum' do
      expect(Task.priorities).to eq({ "low" => 0, "medium" => 1, "high" => 2 })
    end

    it 'defaults status to todo' do
      campaign = Campaign.create!(name: "Test Campaign")
      task = Task.create!(title: "Test Task", campaign: campaign)
      expect(task.status).to eq("todo")
    end

    it 'defaults priority to medium' do
      campaign = Campaign.create!(name: "Test Campaign")
      task = Task.create!(title: "Test Task", campaign: campaign)
      expect(task.priority).to eq("medium")
    end
  end

  describe 'associations' do
    it 'belongs to campaign' do
      association = Task.reflect_on_association(:campaign)
      expect(association.macro).to eq(:belongs_to)
    end

    # BONUS: User relationship tests
    it 'belongs to created_by user' do
      association = Task.reflect_on_association(:created_by)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.options[:optional]).to be true
    end

    it 'belongs to assigned_to user' do
      association = Task.reflect_on_association(:assigned_to)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.options[:optional]).to be true
    end
  end
end