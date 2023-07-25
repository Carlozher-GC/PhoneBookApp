module ApplicationHelper
    def submit_button_text
        return 'Create' if controller.action_name.in? ['new', 'create']
        return 'Update' if controller.action_name.in? ['edit', 'update']

        'Submit'
    end
end
