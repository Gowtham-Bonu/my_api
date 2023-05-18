module Api
  module V1
    class CommentsController < ApplicationController
      before_action :get_article, only: [:index, :create]
      before_action :get_comment, only: [:show, :update, :destroy]

      def index
        @comments = @article.comments.page params[:page]
        render json: @comments
      end

      def show
        render json: @comment
      end

      def create
        @comment = @article.comments.build(comment_params)
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entitiy
        end
      end

      def update
        if @comment.update(comment_params)
          render json: @comment, status: :ok
        else
          render json: @comment.errors, status: :unprocessable_entitiy
        end
      end

      def destroy
        if @comment.destroy
          render json: @comment, status: :ok
        else
          render json: @comment.errors, status: :unprocessable_entitiy
        end
      end

      def search
        @comments = Comment.where('description LIKE ?', "%#{params[:comment].strip}%").page params[:page]
        render json: @comments
      end 
        
      private

      def get_article
        @article = Article.find(params[:article_id])
      end

      def get_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:description, :date_of_comment)
      end
    end
  end
end