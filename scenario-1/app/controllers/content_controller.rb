class ContentController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    all_content = Content.all

    all_content.each do |c|
      c.data = rotify(c.data)
    end

    render json: all_content
  end

  def save
    if params[:data].present?
      c = Content.new(params.permit(:data))
      c.save

      encoded_text = rotify(params[:data])
      render json: { encoded_text: encoded_text }
    else
      render json: { error: 'Text parameter is missing' }, status: :unprocessable_entity
    end
  end

  private

  def rotify(s)
    result = ''
    base = nil

    s.each_char do |char|
      if char.match(/[a-zA-Z]/)

        if char.downcase == char
          base = 'a'.ord
        else
          base = 'A'.ord
        end

        rotated_ord = (char.ord - base + 13) % 26 + base
        result += rotated_ord.chr
      else
        result += char
      end
    end
    
    result
  end
end
