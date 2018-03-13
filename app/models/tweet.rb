class Tweet < ApplicationRecord
  belongs_to :user

  has_many :tweet_tags
  has_many :tags, through: :tweet_tags

  before_validation :link_check, on: :create

  validates :message, presence: true
  validates :message, length: {maximum: 140, too_long: "Un tweet sólo tiene 140 caracteres. ¡Todo el mundo lo sabe!"}, on: :create

  after_validation :apply_link, on: :create    # :update si no funcionara (quitando ", on: :create" detrás del maximum 140)

  private 

  def link_check
    check = false
    if self.message.include? "http://" 
      check = true
    elsif self.message.include? "https://"
      check = true
    else
      check = false
    end	
    
    if check == true
    	arr = self.message.split
    	index = arr.map{ |x| x.include? "http"}.index(true)
      self.link = arr[index]
      if arr[index].length > 23
    	  arr[index] = "#{arr[index][0..20]}..."	
      end
    				
      self.message = arr.join(" ")

      # Alternativa de código de Manuel

      # url_regexp = /https?:\/\/\S+/

      # self.message.sub!(url_regexp) do |url|
       # self.link = url
       # url.length > 23 ? "#{url[0..20]}..." : url
      # end

    end

  end

  def apply_link
    arr = self.message.split
    index = arr.map { |x| x.include?("http://") || x.include?("https://") }.index(true)
  
    if index
      url = arr[index]
      arr[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
    end
  
    self.message = arr.join(" ")

    # Alternativa de código de Manuel

    # url_regexp = /https?:\/\/\S+/
    # self.message.sub!(url_regexp) do |url|
      # "<a href='#{self.link}' target='_blank'>#{url}</a>"
    # end

  end

end
