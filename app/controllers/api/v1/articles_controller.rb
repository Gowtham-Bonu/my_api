module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :get_article, only: [:show, :update, :destroy]

      def index
        @articles = Article.all.page params[:page]
        render json: @articles
      end

      def show
        render json: @article
      end

      def create
        @article = Article.new(article_params)
        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entitiy
        end
      end

      def update
        if @article.update(article_params)
          render json: @article, status: :ok
        else
          render json: @article.errors, status: :unprocessable_entitiy
        end
      end

      def destroy
        if @article.destroy
          render json: @article, status: :ok
        else
          render json: @article.errors, status: :bad_request
        end
      end

      def search
        @article = Article.where('title LIKE ?', "%#{params[:title].strip}%").page params[:page]
        render json: @article
      end
      
      private

      def get_article
        @article = Article.find_by(id: params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :body, :release_date)
      end
    end
  end
end