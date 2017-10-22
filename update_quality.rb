require 'award'

def update_quality(awards)
  awards.each do |award|
    award.calculate_quality
    award.update_expires
  end
end
