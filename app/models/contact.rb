class Contact < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone, presence: true

    validate :phone_valid

    def phone_valid
        return if phone.match(/^\d{10}$/)

        errors.add(:phone, :invalid_phone, message: 'Phone must contain exactly 10 digits')
    end
end
