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
          render json: @article
        else
          render json: {status: 'ERROR', message: 'article is not created', data: @article.errors}, status: :unprocessable_entitiy
        end
      end

      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: {status: 'ERROR', message: 'article is not updated', data: @article.errors}, status: :unprocessable_entitiy
        end
      end

      def destroy
        @article.destroy
        render json: @article
      end

      def search
        @article = Article.find_by(title: params[:title].strip)
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