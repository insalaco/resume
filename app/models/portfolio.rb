class Portfolio < ApplicationRecord
  has_many :technologies
  validates_presence_of :title, :body, :main_image, :thumb_image

  mount_uploader :thumb_image, PortfolioUploader
  mount_uploader :main_image, PortfolioUploader
  
  accepts_nested_attributes_for :technologies, 
                                reject_if: lambda { |attrs| attrs['name'].blank? }

  scope :ruby_on_rails_portfolio_items, -> { where(subtitle = "Ruby on Rails") }
  
  def self.by_position
    order("position ASC")
  end
  
  after_initialize :set_defaults

  def set_defaults
    # set image defaults if images are nil
    self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
    self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')
  end
end
