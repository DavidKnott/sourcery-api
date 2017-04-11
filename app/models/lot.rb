class Lot < ApplicationRecord
  validates_length_of :uid, minimum: 42, maximum: 42
  validates_uniqueness_of :uid
  validate :uid_start
  validate :uid_hex
  belongs_to :product
  before_validation :generate_uid

  private 

    def generate_uid
      self.uid ||= '0x' + SecureRandom.hex(20)
    end

    def uid_start
      if uid[0..1] != '0x'
        errors.add(:uid, "must start with '0x'")
      end
    end

    def uid_hex
      unless uid[2..-1].chars.all? { |letter| letter =~ /\h/ }
        errors.add(:uid, "must be composed of hexidecimal characters only")
      end
    end
end
