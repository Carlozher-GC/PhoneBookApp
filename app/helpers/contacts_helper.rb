module ContactsHelper
    def format_phone(phone)
        "#{phone[0,3]}-#{phone[3,3]}-#{phone[6,4]}"
    end
end
