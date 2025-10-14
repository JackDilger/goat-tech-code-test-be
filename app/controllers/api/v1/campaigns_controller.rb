module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :set_campaign, only: [:show, :update, :destroy]

      def index
        # BUG 8:
        campaigns = if params[:status]
                      Campaign.where(status: params[:status])
                    else
                      Campaign.all
                    end

        # BUG 7:
        # TODO: Add task_count to each campaign in response once Task model exists.
        #       Will need to map over campaigns and merge task_count: campaign.tasks.size
        render json: { campaigns: campaigns }
      end

      # TODO: Include tasks in JSON response once Task model exists.
      #       Consider eager loading in set_campaign to avoid N+1 queries.
      def show
        # BUG 6:
        render json: { campaign: @campaign }
      end

      def create
        campaign = Campaign.new(campaign_params)

        if campaign.save
          render json: { campaign: campaign }, status: :created
        else
          render json: { errors: campaign.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @campaign.update(campaign_params)
          render json: { campaign: @campaign }
        else
          render json: { errors: @campaign.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @campaign.destroy
        head :no_content
      end

      private

      def set_campaign
        @campaign = Campaign.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Campaign not found' }, status: :not_found
      end

      def campaign_params
        # BUG 5:
        params.require(:campaign).permit(:name, :description, :status)
      end
    end
  end
end