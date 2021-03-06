class Submission < ActiveRecord::Base
  
  attr_accessible :name, :email, :description, :url, :activity, :partner_code
  
  belongs_to :badge

  validates :url, :format => URI::regexp(%w(http https))

  PENDING = 0
  APPROVED = 1
  REJECTED = 2

  def self.has_all?(submission)
    email = submission.email
    Badge.all.each do |badge|
      next if badge.name == "Educator Innovator"
      return false if not badge.find_approved_submission email
    end
    true
  end

  def approved?
    status == APPROVED
  end

  def rejected?
    status == REJECTED
  end

  def pending?
    status == PENDING
  end

  def get_status
    if status == 0
      "Pending"
    elsif status == 1
      "Approved"
    else
      "Rejected"
    end
  end

end
