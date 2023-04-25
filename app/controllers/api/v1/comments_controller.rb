module Api
  module V1
    class CommentsController < ApplicationController
      before_action :get_article, only: [:index]
      before_action :get_comment, only: [:show, :update, :destroy]

      def index
        @comments = @article.comments
        render json: @comments
      end

      def show
        render json: @comment
      end

      def create
        @comment = Comment.new(comment_params)
        if @comment.save
          render json: @comment
        else
          render json: {status: 'ERROR', message: 'comment is not posted', data: @comment.errors}, status: :unprocessable_entitiy
        end
      end

      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: {status: 'ERROR', message: 'comment is not updated', data: @comment.errors}, status: :unprocessable_entitiy
        end
      end

      def destroy
        @comment.destroy
        render json: @comment
      end

      def search
        @comments = Comment.where('description LIKE ?', "%#{params[:comment].strip}%")
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
        params.require(:comment).permit(:description, :date_of_comment, :article_id)
      end
    end
  end
end