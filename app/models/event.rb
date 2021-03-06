class Event < ActiveRecord::Base
  extend FriendlyId
  include Addresseable

  default_scope :order => 'date DESC'
  belongs_to :user, :counter_cache => :events_count

  friendly_id :title, :use => :slugged

  paginates_per 10

  geocoded_by :address
  after_validation :geocode

  attr_accessible :title, :description, :city, :postal_code,
  :street, :date, :website, :latitude, :longitude

  delegate :page, :to => :comments, :prefix => true, :allow_nil => true
  delegate :username, :to => :user, :prefix => true, :allow_nil => true
  delegate :gravatar_url, :to => :user, :prefix => true, :allow_nil => true

  validates_presence_of :city, :street, :user
  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :description, :presence => true, :length => { :maximum => 500 }
  validates :postal_code, :presence => true, :format => {:with => /^[0-9]{5}$/}
  validates_format_of :website, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true
  validates :date, :date => { :after => Time.now, :message => I18n.t('event.error.date') }, :presence => true
end
