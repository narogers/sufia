module Selectors
  module Header
    def user_notifications_link
      within '#user_utility_links' do
        find '#notify_link'
      end
    end

    def user_utility_toggle
      within '#user_utility_links' do
        find '.dropdown-toggle.btn.btn-default'
      end
    end
  end

  module Dashboard
    def db_item_actions_toggle(item)
      within "#document_#{item.id}" do
        find '.dropdown-toggle'
      end
    end
  end

  module NewTransfers
    def new_owner_dropdown
      find '#s2id_proxy_deposit_request_transfer_to'
    end

    def new_owner_search_field
      within '#select2-drop' do
        find '.select2-input'
      end
    end

    def new_owner_search_result
      within '#select2-drop' do
        find '.select2-result-selectable'
      end
    end

    def submit_button
      within '#new_transfer' do
        find 'input[type=submit]'
      end
    end
  end

  module Transfers
    def first_sent_cancel_button
      within '#outgoing-transfers' do
        find '.btn.btn-danger'
      end
    end

    def first_received_accept_dropdown
      within '#incoming-transfers' do
        find '.dropdown-toggle.accept'
      end
    end

    def first_received_reject_button
      within '#incoming-transfers' do
        find '.btn.btn-danger'
      end
    end
  end
end
